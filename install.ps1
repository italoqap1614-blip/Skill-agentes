# install.ps1 — Instalador Automático de Skills & Plugins do Antigravity
# Uso: powershell -ExecutionPolicy Bypass -File install.ps1

$ErrorActionPreference = "Stop"

$dest = "$env:USERPROFILE\.gemini\config"
$pluginsSrc = "$PSScriptRoot\plugins"
$skillsSrc  = "$PSScriptRoot\skills"

Write-Host ""
Write-Host "╔══════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║  🧠  Instalador Antigravity Skills & Plugins  ║" -ForegroundColor Cyan
Write-Host "╚══════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# Verificar se o Antigravity está instalado
if (-not (Test-Path "$env:USERPROFILE\.gemini")) {
    Write-Host "❌ Antigravity não encontrado em ~/.gemini" -ForegroundColor Red
    Write-Host "   Instale o Antigravity IDE antes de continuar." -ForegroundColor Yellow
    exit 1
}

# Criar diretórios de destino se não existirem
New-Item -ItemType Directory -Force -Path "$dest\plugins" | Out-Null
New-Item -ItemType Directory -Force -Path "$dest\skills"  | Out-Null

# Instalar Plugins
if (Test-Path $pluginsSrc) {
    $plugins = Get-ChildItem -Directory $pluginsSrc
    Write-Host "📦 Instalando $($plugins.Count) plugin(s)..." -ForegroundColor Blue
    foreach ($plugin in $plugins) {
        $pluginDest = "$dest\plugins\$($plugin.Name)"
        Copy-Item -Recurse -Force $plugin.FullName "$dest\plugins\"
        Write-Host "   ✅ Plugin: $($plugin.Name)" -ForegroundColor Green
    }
} else {
    Write-Host "⚠️  Pasta 'plugins/' não encontrada. Pulando plugins." -ForegroundColor Yellow
}

Write-Host ""

# Instalar Skills individuais
if (Test-Path $skillsSrc) {
    $skills = Get-ChildItem -Directory $skillsSrc
    Write-Host "🛠️  Instalando $($skills.Count) skill(s)..." -ForegroundColor Blue
    foreach ($skill in $skills) {
        Copy-Item -Recurse -Force $skill.FullName "$dest\skills\"
        Write-Host "   ✅ Skill: $($skill.Name)" -ForegroundColor Green
    }
} else {
    Write-Host "⚠️  Pasta 'skills/' não encontrada. Pulando skills." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "╔══════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║  ✅  Instalação concluída com sucesso!        ║" -ForegroundColor Green
Write-Host "║  🔄  Reinicie o Antigravity IDE.              ║" -ForegroundColor Yellow
Write-Host "╚══════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""
