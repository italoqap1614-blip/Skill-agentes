# 🧠 Skill-agentes — Catálogo Antigravity

> Repositório de referência e instalação de **Skills** e **Agentes** do ambiente Antigravity de **Ítalo Nascimento**.

[![Antigravity](https://img.shields.io/badge/Antigravity-IDE-6366f1?style=flat-square)](https://antigravity.dev)
[![Skills](https://img.shields.io/badge/Skills-~70-22c55e?style=flat-square)](#skills)
[![Agents](https://img.shields.io/badge/Subagentes-4-f59e0b?style=flat-square)](#subagentes)
[![Plugins](https://img.shields.io/badge/Plugins-5-3b82f6?style=flat-square)](#plugins)

---

## 📦 Instalação Rápida (Notebook)

### Pré-requisitos
- [Antigravity IDE](https://antigravity.dev) instalado
- Git configurado

### Instalar todos os plugins via `agy`

```powershell
# 1. Clone este repositório
git clone https://github.com/italoqap1614-blip/Skill-agentes.git

# 2. Entre na pasta
cd Skill-agentes

# 3. Execute o script de instalação automática
powershell -ExecutionPolicy Bypass -File install.ps1
```

> O script `install.ps1` copia os plugins e skills para `~/.gemini/config/` automaticamente.

### Instalação manual (alternativa)

```powershell
# Copiar plugins para a config global do Antigravity
$dest = "$env:USERPROFILE\.gemini\config"
Copy-Item -Recurse -Force ".\plugins\*" "$dest\plugins\"
Copy-Item -Recurse -Force ".\skills\*"  "$dest\skills\"
Write-Host "✅ Instalação concluída! Reinicie o Antigravity IDE."
```

---

## 🤖 Subagentes

| Agente | Descrição |
|---|---|
| **code-reviewer** | Revisor sênior de código em 5 dimensões: correção, legibilidade, arquitetura, segurança e performance |
| **security-auditor** | Auditoria de vulnerabilidades, modelagem de ameaças e práticas de código seguro |
| **test-engineer** | Estratégia de testes, escrita de testes e análise de cobertura |
| **web-performance-auditor** | Core Web Vitals, loading, rendering e otimização de rede |

---

## 🎨 Skills por Categoria

### Design & Animação

| Skill | Descrição |
|---|---|
| `animate` | Animações web do zero com decisões de purpose, tool, easing e duration |
| `animate-expo` | Animações React Native/Expo com Reanimated, Gesture Handler e haptics |
| `animation-vocabulary` | Glossário reverso de motion — "o efeito bouncy" → Pop in |
| `design-motion-principles` | Motion design nível Emil Kowalski / Jakub Krehel / Jhey Tompkins |
| `design-taste-frontend` | Anti-slop frontend para landing pages e portfólios |
| `emil-design-eng` | Filosofia de UI polish e detalhes invisíveis de Emil Kowalski |
| `find-animation-opportunities` | Varre o codebase buscando onde animar (read-only) |
| `improve-animations` | Audita motion do codebase e gera roadmap priorizado (read-only) |
| `industrial-brutalist-ui` | UI brutalista mecânica — tipografia Swiss, estética terminal |
| `brandkit` | Brand-kits premium: logo systems, identity decks, mockups |
| `imagegen-frontend-web` | Referências visuais section-by-section para landing pages |
| `image-to-code` | Analisa imagem de design e implementa HTML/CSS fiel |

### 🌀 GSAP

| Skill | Descrição |
|---|---|
| `gsap-core` | `gsap.to()`, `from()`, easing, stagger, `matchMedia()` |
| `gsap-react` | GSAP em React/Next.js — `useGSAP`, refs, cleanup |
| `gsap-frameworks` | GSAP em Vue, Nuxt, Svelte, SvelteKit |
| `gsap-timeline` | Timelines, position parameter, nesting, playback |
| `gsap-scrolltrigger` | Scroll animations, pinning, scrub, parallax |
| `gsap-plugins` | ScrollSmooth, Flip, Draggable, SplitText, CustomEase |
| `gsap-performance` | 60fps, will-change, batching, layout thrashing |
| `gsap-utils` | clamp, mapRange, normalize, random, snap, wrap |

### 🌐 Web Frontend

| Skill | Descrição |
|---|---|
| `modern-web-guidance` | ⚠️ OBRIGATÓRIO para HTML/CSS/JS — APIs modernas, CWV |
| `frontend-ui-engineering` | UIs acessíveis, responsivas e de produção |
| `chrome-extensions` | Criar e publicar extensões Chrome com Manifest V3 |
| `ask-sonner` | Integração Sonner (toast library para React) |

### 🔥 Firebase

| Skill | Descrição |
|---|---|
| `firebase-basics` | Setup, CLI, projetos, google-services.json |
| `firebase-ai-logic-basics` | Gemini API integrada a apps web |
| `firebase-app-hosting-basics` | Deploy Next.js/Angular no Firebase App Hosting |
| `firebase-auth-basics` | Autenticação, sessões e regras de acesso |
| `firebase-crashlytics` | Crash reporting com Crashlytics SDK |
| `firebase-data-connect` | SQL Connect com PostgreSQL — schemas, mutations, SDKs |
| `firebase-firestore` | ⚠️ OBRIGATÓRIO para Firestore — queries, regras, índices |
| `firebase-hosting-basics` | Deploy SPAs no Firebase Hosting Clássico |
| `firebase-remote-config-basics` | Feature flags e configuração dinâmica |
| `firebase-security-rules-auditor` | Auditoria de segurança das regras Firestore |
| `xcode-project-setup` | Swift Packages e links em projetos Xcode |

### 🐘 Supabase & Postgres

| Skill | Descrição |
|---|---|
| `supabase` | Qualquer tarefa Supabase — Auth, Firestore, Edge Functions, RLS |
| `supabase-postgres-best-practices` | ⚠️ OBRIGATÓRIO antes de schema, RLS, índices, migrações |
| `supabase-chanceler-security-hardening` | Segurança avançada — RLS DDL padrão, auditoria 12-fases |

### ☁️ GCP & Dados

| Skill | Descrição |
|---|---|
| `bigquery-sql` | Otimização de queries e SQL performático |
| `bigquery-ai-ml` | ML e GenAI dentro do BigQuery |
| `bigquery-bigframes` | DataFrames pandas-style sobre BigQuery |
| `bigquery-data-transfer-service` | Pipelines de ingestão DTS |
| `bigquery-graph` | Property graphs com GQL no BigQuery |
| `building-data-apps` | Apps de dados com React+Vite ou Streamlit |
| `data-autocleaning` | Qualidade e transformação de dados |
| `dataform-bigquery` | Pipelines Dataform/ELT — SQLX, projeto |
| `dbt-bigquery` | Modelos dbt para BigQuery |
| `discovering-gcp-data-assets` | Encontrar e inspecionar datasets e tabelas GCP |
| `enforcing-resource-attribution` | Atribuição de recursos em `bq` e `gcloud` |
| `federate-lakehouse-catalog` | Conectar GCP a Databricks/AWS Glue via Iceberg |
| `gcloud-auth-verification` | Resolver erros de autenticação GCP e ADC |
| `gcp-composer-troubleshooting` | Troubleshooting Cloud Composer/Airflow e RCA |
| `gcp-data-pipelines` | Entry point para pipelines GCP |
| `gcp-dataflow` | Apache Beam no Dataflow — Flex Templates |
| `gcp-managed-airflow-migrations` | Migração DAGs Airflow para MSAA Gen 2/3 |
| `gcp-pipeline-orchestration` | Orquestração Cloud Composer |
| `gcp-pipeline-resource-provisioning` | Provisionamento declarativo via deployment.yaml |
| `gcp-spark` | Spark ETL em Dataproc — BigLake, BigQuery, Spanner |
| `gcs-security-assessment` | Segurança de buckets GCS e conformidade SAIF |
| `accidental-data-loss-prevention` | 🛑 OBRIGATÓRIO antes de DROP, TRUNCATE, DELETE |
| `notebook-guidance` | Notebooks Jupyter com BigQuery |
| `ml-best-practices` | ⚠️ OBRIGATÓRIO para qualquer tarefa de ML |
| `managing-python-dependencies` | Dependências Python sem pip install global |

### ⚙️ Engenharia de Software

| Skill | Descrição |
|---|---|
| `spec-driven-development` | Specs antes de codar |
| `planning-and-task-breakdown` | Quebrar trabalho em tarefas implementáveis |
| `incremental-implementation` | Entregas incrementais em múltiplos arquivos |
| `test-driven-development` | TDD — implementação guiada por testes |
| `debugging-and-error-recovery` | Root-cause analysis sistemático |
| `code-review-and-quality` | Revisão multi-eixo pré-merge |
| `code-simplification` | Refatorar para clareza sem mudar comportamento |
| `api-and-interface-design` | Design estável de APIs REST/GraphQL |
| `backend-architect` | Arquitetura de backend escalável |
| `security-and-hardening` | Hardening contra vulnerabilidades |
| `performance-optimization` | Core Web Vitals, N+1, otimização geral |
| `observability-and-instrumentation` | Logging, métricas, tracing, alerting |
| `documentation-and-adrs` | ADRs e documentação arquitetural |
| `deprecation-and-migration` | Remoção de sistemas e APIs legadas |
| `git-workflow-and-versioning` | Commits, branches, semantic versioning |
| `ci-cd-and-automation` | Pipelines CI/CD, quality gates, deployment |
| `shipping-and-launch` | Checklist de lançamento e rollback |
| `source-driven-development` | Implementações baseadas em docs oficiais |
| `doubt-driven-development` | Revisão adversarial em decisões de alto risco |
| `browser-testing-with-devtools` | Testes reais via Chrome DevTools MCP |
| `context-engineering` | Setup de contexto e rules files |
| `using-agent-skills` | Meta-skill para descobrir outras skills |
| `idea-refine` | Refinar ideias via pensamento divergente/convergente |
| `interview-me` | Entrevista estruturada para extrair requisitos reais |

### 🛰️ Antigravity SDK

| Skill | Descrição |
|---|---|
| `antigravity-guide` | Guia completo — CLI, IDE, Python SDK, slash commands |
| `agy-customizations` | Criar skills, rules, plugins, hooks e MCP servers |
| `google-antigravity-sdk` | Agentes autônomos e sistemas multi-agente com AGY SDK |

---

## 🧩 Plugins

| Plugin | Skills | Notas |
|---|---|---|
| `agent-skills` | 24 skills + 4 subagentes | Engenharia de software completa |
| `data-agent-kit-plugin` | 25 skills | GCP, BigQuery, Spark, dbt, Dataflow |
| `firebase` | 11 skills | Firebase completo + Xcode |
| `modern-web-guidance-plugin` | 2 skills | Web moderna + Chrome Extensions |
| `google-antigravity-sdk` | 1 skill | SDK de agentes autônomos |

---

## ⚠️ Skills de Ativação Obrigatória

| Gatilho | Skill |
|---|---|
| Qualquer operação Firestore | `firebase-firestore` |
| Qualquer tarefa HTML/CSS/JS | `modern-web-guidance` |
| Qualquer ML ou análise de dados | `ml-best-practices` |
| DROP / TRUNCATE / DELETE sem WHERE | `accidental-data-loss-prevention` |
| Schema/RLS/índices no Postgres | `supabase-postgres-best-practices` |

---

## 📁 Estrutura do Repositório

```
Skill-agentes/
├── README.md           ← Este arquivo (catálogo completo)
├── install.ps1         ← Script de instalação automática (Windows)
├── install.sh          ← Script de instalação automática (Linux/macOS)
├── plugins/            ← Plugins prontos para instalar
│   ├── agent-skills/
│   ├── data-agent-kit-plugin/
│   ├── firebase/
│   ├── modern-web-guidance-plugin/
│   └── google-antigravity-sdk/
└── skills/             ← Skills individuais (globais)
    ├── animate/
    ├── gsap-core/
    ├── supabase/
    └── ... (~29 skills)
```

---

*Mantido por **Ítalo Nascimento** · Ambiente: Antigravity IDE*
