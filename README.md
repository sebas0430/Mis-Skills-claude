# Mis Skills de Claude Code

Backup de mi configuración de skills, plugins y servidores MCP de Claude Code, para restaurarla en cualquier PC.

## Contenido

- `humanizer/` — skill que reescribe texto para que no suene generado por IA ([blader/humanizer](https://github.com/blader/humanizer))
- `napkin/` — skill de memoria persistente por repo, un runbook curado de correcciones/preferencias ([blader/napkin](https://github.com/blader/napkin))
- `setup.sh` — instala lo anterior más los plugins oficiales de Anthropic (`claude-code-setup`, `project-artifact`, `mcp-server-dev`, `feature-dev`, `code-review`, `github`) y los servidores MCP de DevOps (`kubernetes-mcp-server`, `mcp-server-docker`)

## Instalación en un PC nuevo

```bash
git clone https://github.com/sebas0430/Mis-Skills-claude.git
cd Mis-Skills-claude
chmod +x setup.sh
./setup.sh
```

Después:
- Exporta `GITHUB_PERSONAL_ACCESS_TOKEN` (scope `repo` + `actions:read`/`actions:write`) para que funcione el plugin de GitHub.
- Asegúrate de tener `~/.kube/config` apuntando a tu cluster para `kubernetes-mcp-server`.
- Reinicia la sesión de Claude Code.
