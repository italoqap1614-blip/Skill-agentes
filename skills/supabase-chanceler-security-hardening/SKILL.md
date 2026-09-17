---
name: supabase-chanceler-security-hardening
description: Skill global com diretrizes, padrões DDL de RLS PostgreSQL/Supabase, RPC sem parâmetros, testes REST 401, remoção de localStorage e procedimentos de auditoria 12-Fases para segurança do Chanceler.
---

# Supabase Chanceler Security Hardening & Protocolo de Homologação

> **Finalidade:** Guia completo de padrões de segurança, DDL PostgreSQL idempotente, testes REST automatizados, hardening frontend e serverless para o sistema **Presença Maçônica** (Supabase + React + Vercel).

---

## 1. Princípio Fundamental de Segurança (Fail-Closed)

- **Default Deny (Bloqueio por Padrão):** Nenhuma tabela sensível (`brothers`, `meetings`, `email_logs`, `birthday_publications`, `interlodge_visits`) deve permitir leitura ou escrita sem autenticação prévia.
- **Fail-Closed no Rollback:** O script de rollback de segurança nunca deve reintroduzir políticas abertas `USING (true)` para a role `authenticated` ou `public`. Se o RLS for revertido, o acesso permanece fechado.
- **Zero LocalStorage para Dados de Negócio:** `localStorage`, `sessionStorage` e `indexedDB` no navegador devem armazenar apenas preferências visuais ou tokens de sessão gerenciados pelo SDK do Supabase Auth. Dados de maçons, presenças e visitas devem trafegar estritamente via banco de dados autenticado.

---

## 2. Padrão PostgreSQL RLS & DDL Idempotente

### 2.1 Schema de Controle de Acesso (`app.app_users`)

```sql
CREATE SCHEMA IF NOT EXISTS app;
GRANT USAGE ON SCHEMA app TO authenticated;

CREATE TABLE IF NOT EXISTS app.app_users (
  user_id uuid PRIMARY KEY REFERENCES auth.users(id) ON DELETE RESTRICT,
  role text NOT NULL CHECK (role = 'chanceler'),
  active boolean NOT NULL DEFAULT true,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE app.app_users ENABLE ROW LEVEL SECURITY;
```

### 2.2 Função de Autorização sem Parâmetros Arbitrários

> ⚠️ **Crítico:** A função **não pode receber `p_user_id` como parâmetro**. O ID do usuário deve ser extraído obrigatoriamente do contexto seguro do JWT via `auth.uid()`.

```sql
CREATE OR REPLACE FUNCTION app.is_authorized_chanceler()
RETURNS boolean
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = app, public
AS $$
  SELECT EXISTS (
    SELECT 1
    FROM app.app_users u
    WHERE u.user_id = auth.uid()
      AND u.role = 'chanceler'
      AND u.active = true
  );
$$;

REVOKE ALL ON FUNCTION app.is_authorized_chanceler() FROM public, anon;
GRANT EXECUTE ON FUNCTION app.is_authorized_chanceler() TO authenticated;
```

### 2.3 Idempotência DDL e Ordem Correta de Execução

Para evitar erros PostgreSQL de dependência (`2BP01: cannot drop function... because other objects depend on it`) e de funções não únicas (`42725: function is not unique`):

1. **Passo 1:** Executar todos os `DROP POLICY IF EXISTS` primeiro (incluindo políticas legadas inseguras `"Allow all"` e `"Allow authenticated only"`).
2. **Passo 2:** Executar `DROP FUNCTION IF EXISTS ... CASCADE` nas funções sobrecarregadas legadas.
3. **Passo 3:** Recriar as funções no schema `app` e o wrapper no schema `public`.
4. **Passo 4:** Aplicar `REVOKE ALL ON public.tabela FROM anon;` em todas as tabelas sensíveis.
5. **Passo 5:** Recriar as políticas restritas `*_chanceler` utilizando `USING (app.is_authorized_chanceler())` e `WITH CHECK (app.is_authorized_chanceler())`.

---

## 3. Hardening de Serverless Functions (`/api/`)

Todas as Serverless Functions da Vercel (ex: `/api/generate-email` e `/api/generate-birthday-message`) devem implementar a seguinte sequência de verificação **antes** de chamar qualquer provedor externo de IA (Gemini):

1. **Método HTTP:** Validar se o método é `POST` (retornar `405` se incorreto).
2. **Validação de Body:** Verificar se `req.body` existe e é um objeto (retornar `400` se inválido).
3. **Guarda JWT:** Extrair `req.headers.authorization`. Validar formato `Bearer <token>` (retornar `401` se ausente/inválido).
4. **Validação de Sessão Supabase:** Executar `supabase.auth.getUser(token)`. Se falhar, retornar `401`.
5. **Checagem de Autorização Chanceler:** Executar `supabase.rpc('is_authorized_chanceler')`. Se retornar falso ou erro, retornar `403 Forbidden`.
6. **Segregação de SDK:** O SDK `@google/genai` e a chave `GEMINI_API_KEY` devem existir estritamente no ambiente do servidor Node.js.

---

## 4. Script de Homologação de Segurança REST (Bateria Automatizada)

Para testar a API REST externa do Supabase sem expor dados reais:

```javascript
const https = require('https');

const SUPABASE_URL = 'https://bxmkcmrqmgxundfhxuya.supabase.co';
const ANON_KEY = 'SUA_CHAVE_PUBLICA_ANON';

async function testEndpoint(endpoint, headers = {}) {
  return new Promise((resolve) => {
    const url = new URL(endpoint, SUPABASE_URL);
    const req = https.request({
      hostname: url.hostname,
      port: 443,
      path: url.pathname + url.search,
      method: 'GET',
      headers: { 'apikey': ANON_KEY, ...headers }
    }, (res) => {
      let body = '';
      res.on('data', chunk => body += chunk);
      res.on('end', () => resolve({ status: res.statusCode, data: body }));
    });
    req.on('error', err => resolve({ status: 500, data: err.message }));
    req.end();
  });
}

async function runAudit() {
  const tables = ['brothers', 'meetings', 'email_logs', 'birthday_publications', 'interlodge_visits'];
  for (const table of tables) {
    const res = await testEndpoint(`/rest/v1/${table}?select=id&limit=1`);
    console.log(`[REST] ${table}: Status ${res.status} (Esperado 401)`);
  }
}

runAudit();
```

---

## 5. Auditoria do Bundle e Varredura de Segredos

Executar os seguintes comandos no terminal antes de qualquer release:

```bash
# 1. Compilação TypeScript e Build Vite
npm run build
npx tsc --noEmit

# 2. Varredura por segredos expostos no código-fonte
git grep -n -E "service_role|SUPABASE_SERVICE_ROLE|SUPABASE_SECRET|GEMINI_API_KEY|AIza" -- . || true

# 3. Varredura por segredos no bundle final estático
grep -Rni -E "service_role|SUPABASE_SECRET|GEMINI_API_KEY" dist/ || true

# 4. Varredura por localStorage de dados de negócio
git grep -n -E "localStorage|sessionStorage|indexedDB|LOCAL_STORAGE_KEY|INITIAL_PUBLICATIONS" -- src api public || true
```

**Critério de Aprovação:** 0 ocorrências de secrets em `dist/` e 0 ocorrências de `localStorage` para dados de negócio.

---

## 6. Security Headers Recomendados (`vercel.json`)

```json
{
  "headers": [
    {
      "source": "/(.*)",
      "headers": [
        { "key": "Strict-Transport-Security", "value": "max-age=63072000; includeSubDomains; preload" },
        { "key": "X-Content-Type-Options", "value": "nosniff" },
        { "key": "X-Frame-Options", "value": "DENY" },
        { "key": "Referrer-Policy", "value": "strict-origin-when-cross-origin" },
        { "key": "Permissions-Policy", "value": "camera=(), microphone=(), geolocation=()" },
        { "key": "Content-Security-Policy", "value": "default-src 'self'; script-src 'self'; style-src 'self' 'unsafe-inline' https://fonts.googleapis.com; font-src 'self' https://fonts.gstatic.com; img-src 'self' data: blob: https:; connect-src 'self' https://bxmkcmrqmgxundfhxuya.supabase.co https://generativelanguage.googleapis.com; frame-ancestors 'none';" }
      ]
    }
  ]
}
```

---

## 7. Checklist do Portão de Liberação (GO Gate)

Para declarar `GO DEFINITIVO` para produção, os 12 critérios abaixo devem passar com evidências empíricas:

1. **Commit Auditado:** Commit limpo e identificado na branch de segurança.
2. **Build & Typecheck:** `npm run build` e `npx tsc --noEmit` executados com 0 erros.
3. **Zero Secrets:** Varredura em `dist/` confirmou ausência de `service_role` ou chaves de IA.
4. **Zero LocalStorage:** Dados de maçons, presenças e visitas trafegam 100% via Supabase REST.
5. **Idempotência DDL:** Migration aplicada sem erros `2BP01`, `42710` ou `42725`.
6. **Eliminação de Políticas Inseguras:** `pg_policies` confirmou a remoção de todas as políticas `"Allow all"`.
7. **REST Anônimo Bloqueado:** Chamadas sem JWT em todas as 5 tabelas sensíveis retornam `HTTP 401`.
8. **RPC Anônima Bloqueada:** Chamada sem JWT para `is_authorized_chanceler` retorna `HTTP 401`.
9. **Guardas Serverless:** `/api/generate-email` e `/api/generate-birthday-message` rejeitam requisições sem JWT (`HTTP 401`).
10. **Chanceler Único Ativo:** Tabela `app.app_users` contém o UUID do Chanceler com `role = 'chanceler'` e `active = true`.
11. **Rollback Fail-Closed:** Script de rollback preparado mantendo RLS ativado e sem politicas abertas.
12. **Autorização Explícita Humana:** Confirmação literal do responsável com a frase `AUTORIZO DEPLOY EM PRODUÇÃO`.
