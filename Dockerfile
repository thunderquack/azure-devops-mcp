FROM node:22-alpine

ARG MCP_VERSION=2.5.0

RUN npm config set update-notifier false \
    && npm install -g "@azure-devops/mcp@${MCP_VERSION}" \
    && addgroup -S mcp && adduser -S -G mcp mcp

USER mcp
WORKDIR /home/mcp

ENTRYPOINT ["mcp-server-azuredevops"]