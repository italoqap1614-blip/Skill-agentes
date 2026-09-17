#!/usr/bin/env bash
# install.sh — Instalador Automático de Skills & Plugins do Antigravity
# Uso: bash install.sh

set -e

DEST="$HOME/.gemini/config"
PLUGINS_SRC="$(dirname "$0")/plugins"
SKILLS_SRC="$(dirname "$0")/skills"

echo ""
echo "╔══════════════════════════════════════════════╗"
echo "║  🧠  Instalador Antigravity Skills & Plugins  ║"
echo "╚══════════════════════════════════════════════╝"
echo ""

# Verificar Antigravity
if [ ! -d "$HOME/.gemini" ]; then
  echo "❌ Antigravity não encontrado em ~/.gemini"
  echo "   Instale o Antigravity IDE antes de continuar."
  exit 1
fi

mkdir -p "$DEST/plugins"
mkdir -p "$DEST/skills"

# Instalar Plugins
if [ -d "$PLUGINS_SRC" ]; then
  echo "📦 Instalando plugins..."
  for plugin in "$PLUGINS_SRC"/*/; do
    name=$(basename "$plugin")
    cp -rf "$plugin" "$DEST/plugins/"
    echo "   ✅ Plugin: $name"
  done
else
  echo "⚠️  Pasta 'plugins/' não encontrada. Pulando plugins."
fi

echo ""

# Instalar Skills
if [ -d "$SKILLS_SRC" ]; then
  echo "🛠️  Instalando skills..."
  for skill in "$SKILLS_SRC"/*/; do
    name=$(basename "$skill")
    cp -rf "$skill" "$DEST/skills/"
    echo "   ✅ Skill: $name"
  done
else
  echo "⚠️  Pasta 'skills/' não encontrada. Pulando skills."
fi

echo ""
echo "╔══════════════════════════════════════════════╗"
echo "║  ✅  Instalação concluída com sucesso!        ║"
echo "║  🔄  Reinicie o Antigravity IDE.              ║"
echo "╚══════════════════════════════════════════════╝"
echo ""
