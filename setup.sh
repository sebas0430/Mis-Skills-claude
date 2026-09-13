#!/usr/bin/env bash
# Reinstala en un PC nuevo todas las skills, plugins y MCP servers de este repo.
set -e

echo "== Skills locales (humanizer, napkin, decision-critic) =="
mkdir -p ~/.claude/skills
cp -r "$(dirname "$0")/humanizer" ~/.claude/skills/humanizer
cp -r "$(dirname "$0")/napkin" ~/.claude/skills/napkin
cp -r "$(dirname "$0")/decision-critic" ~/.claude/skills/decision-critic

echo "== Agentes locales (decision-critic) =="
mkdir -p ~/.claude/agents
cp "$(dirname "$0")/agents/decision-critic.md" ~/.claude/agents/decision-critic.md

echo "== Marketplace oficial de Anthropic =="
claude plugin marketplace add anthropics/claude-plugins-official || true

echo "== Plugins oficiales =="
claude plugin install claude-code-setup@claude-plugins-official
claude plugin install project-artifact@claude-plugins-official
claude plugin install mcp-server-dev@claude-plugins-official
claude plugin install feature-dev@claude-plugins-official
claude plugin install code-review@claude-plugins-official
claude plugin install github@claude-plugins-official

echo "== Servidores MCP (DevOps) =="
if ! command -v uv >/dev/null 2>&1; then
  curl -LsSf https://astral.sh/uv/install.sh | sh
  export PATH="$HOME/.local/bin:$PATH"
fi
claude mcp add-json kubernetes-mcp-server '{"command":"npx","args":["-y","kubernetes-mcp-server@latest"]}' -s user
claude mcp add-json mcp-server-docker '{"command":"uvx","args":["mcp-server-docker"]}' -s user

echo "== Listo =="
echo "Recuerda:"
echo "  - Exportar GITHUB_PERSONAL_ACCESS_TOKEN para que funcione el plugin de GitHub"
echo "  - Tener tu ~/.kube/config listo para kubernetes-mcp-server"
echo "  - Reiniciar la sesion de Claude Code para que cargue todo"
