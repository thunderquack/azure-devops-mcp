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

## Notes

- Use PAT with minimal required scopes.
- Rotate the token if it was exposed in logs/history.
- You can switch to latest package with `--build-arg MCP_VERSION=latest`.