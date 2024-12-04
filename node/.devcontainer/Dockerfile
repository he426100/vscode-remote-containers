# [Choice] Node.js version: https://mcr.microsoft.com/v2/devcontainers/javascript-node/tags/list
ARG VARIANT="16-bullseye"
FROM mcr.microsoft.com/devcontainers/javascript-node:1-${VARIANT}

# [Optional] Uncomment this section to install additional OS packages.
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends <your-package-list-here>

# [Optional] Uncomment if you want to install an additional version of node using nvm
# ARG EXTRA_NODE_VERSION=10
# RUN su node -c "source /usr/local/share/nvm/nvm.sh && nvm install ${EXTRA_NODE_VERSION}"

# [Optional] Uncomment if you want to install more global node modules
# RUN su node -c "npm install -g corepack" \
#     && npm cache clean --force > /dev/null 2>&1

USER node
