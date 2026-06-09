#!/usr/bin/env bash
# Instalador del kit de Memoria Persistente (macOS / Linux).
# Copia las plantillas a ~/.memoria-persistente y los comandos a las carpetas globales de
# cada herramienta, sustituyendo __KIT_HOME__ por la ruta absoluta de este equipo.
set -euo pipefail

kitRoot="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
kitHome="$HOME/.memoria-persistente"

echo "Instalando kit de memoria persistente..."
echo "  Kit:  $kitRoot"
echo "  Home: $kitHome"

# 1) Plantillas + VERSION
rm -rf "$kitHome/templates"
mkdir -p "$kitHome"
cp -R "$kitRoot/templates" "$kitHome/templates"
cp -f "$kitRoot/VERSION" "$kitHome/VERSION"

# 2) Comandos a las carpetas globales (sustituyendo __KIT_HOME__)
install_cmds() {
  local src="$1" dest="$2"
  [ -d "$src" ] || return 0
  mkdir -p "$dest"
  for f in "$src"/*; do
    [ -f "$f" ] || continue
    sed "s|__KIT_HOME__|$kitHome|g" "$f" > "$dest/$(basename "$f")"
    echo "  + $dest/$(basename "$f")"
  done
}

install_cmds "$kitRoot/claude/commands"  "$HOME/.claude/commands"
install_cmds "$kitRoot/gemini/commands"  "$HOME/.gemini/commands"
install_cmds "$kitRoot/opencode/command" "$HOME/.config/opencode/command"
install_cmds "$kitRoot/codex/prompts"    "$HOME/.codex/prompts"

echo
echo "OK. Comandos /inicio, /nota y /cierre instalados en global."
echo "Cursor : copia cursor/memoria.mdc a .cursor/rules/ del proyecto (regla manual)."
echo "ChatGPT: usa chatgpt/system-prompt.md en un Custom GPT."
