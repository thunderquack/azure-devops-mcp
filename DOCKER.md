# Azure DevOps MCP in Docker

This wraps the official Microsoft MCP server (`@azure-devops/mcp`) into a container image.

## Build

```bash
docker build -t ado-mcp:2.5.0 --build-arg MCP_VERSION=2.5.0 .
```

## Run (manual)

```bash
docker run --rm -i \
  -e ADO_MCP_AUTH_TOKEN \
  ado-mcp:2.5.0 \
  your-org-name --authentication envvar -d core -d repositories -d pipelines
```

## VS Code `mcp.json` example

```json
{
  "servers": {
    "ado": {
      "type": "stdio",
      "command": "docker",
      "args": [
        "run",
        "--rm",
        "-i",
        "-e",
        "ADO_MCP_AUTH_TOKEN",
        "ado-mcp:2.5.0",
        "your-org-name",
        "--authentication",
        "envvar",
        "-d",
        "core",
        "-d",
        "repositories",
        "-d",
        "pipelines"
      ],
      "env": {
        "ADO_MCP_AUTH_TOKEN": "${env:ADO_MCP_AUTH_TOKEN}"
      }
    }
  }
}
```

## Codex `config.toml` example

```toml
[mcp_servers.azure_devops]
command = "docker"
args = [
  "run", "--rm", "-i",
  "-e", "ADO_MCP_AUTH_TOKEN=YOURS_PAT",
  "thunderquack/ado-mcp:latest",
  "contoso",
  "--authentication", "envvar",
  "-d", "core",
  "-d", "work",
  "-d", "work-items",
  "-d", "search",
  "-d", "repositories",
  "-d", "pipelines"
]
```

## Environment variable alternative

Instead of storing the PAT directly in `config.toml`, you can set `ADO_MCP_AUTH_TOKEN` in the host environment and pass it through to Docker.

### Bash

```bash
export ADO_MCP_AUTH_TOKEN="your-pat-here"
```

### PowerShell

```powershell
$env:ADO_MCP_AUTH_TOKEN="your-pat-here"
```

Then use this alternative `config.toml` form:

```toml
[mcp_servers.azure_devops]
command = "docker"
args = [
  "run", "--rm", "-i",
  "-e", "ADO_MCP_AUTH_TOKEN",
  "thunderquack/ado-mcp:latest",
  "contoso",
  "--authentication", "envvar",
  "-d", "core",
  "-d", "work",
  "-d", "work-items",
  "-d", "search",
  "-d", "repositories",
  "-d", "pipelines"
]
```

## Notes

- Use PAT with minimal required scopes.
- Rotate the token if it was exposed in logs/history.
- You can switch to latest package with `--build-arg MCP_VERSION=latest`.
