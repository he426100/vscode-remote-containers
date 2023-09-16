# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.209.3/containers/php/.devcontainer/base.Dockerfile

# [Choice] PHP version (use -bullseye variants on local arm64/Apple Silicon): 8, 8.1, 8.0, 7, 7.4, 7.3, 8-bullseye, 8.1-bullseye, 8.0-bullseye, 7-bullseye, 7.4-bullseye, 7.3-bullseye, 8-buster, 8.1-buster, 8.0-buster, 7-buster, 7.4-buster
ARG VARIANT="8.1-apache-bullseye"
FROM mcr.microsoft.com/vscode/devcontainers/php:0-${VARIANT}

# [Choice] Node.js version: none, lts/*, 16, 14, 12, 10
ARG NODE_VERSION="none"
RUN if [ "${NODE_VERSION}" != "none" ]; then su vscode -c "umask 0002 && . /usr/local/share/nvm/nvm.sh && nvm install ${NODE_VERSION} 2>&1"; fi

# [Optional] Uncomment this section to install additional OS packages.
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends libicu-dev libpng-dev libxslt1-dev libzip-dev libxml2-dev zip \
    && docker-php-ext-install bcmath gd gettext intl mysqli pcntl pdo_mysql sockets sysvsem xmlwriter xsl zip \
    && a2enmod rewrite && a2enmod headers \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# Install redis
RUN set -ex \
    && pecl update-channels \
    && pecl install redis \
    && docker-php-ext-enable redis \
    && rm -rf /tmp/pear

# vscode tunnel
RUN curl -sL "https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64" \
    --output /tmp/vscode-cli.tar.gz && \
    tar -xf /tmp/vscode-cli.tar.gz -C /usr/bin && \
    rm /tmp/vscode-cli.tar.gz

RUN mkdir /home/vscode/.vscode /workspaces
RUN chown vscode: /home/vscode/.vscode /workspaces

VOLUME /home/vscode/.vscode
VOLUME /workspaces

# [Optional] Uncomment this line to install global node packages.
RUN su vscode -c "source /usr/local/share/nvm/nvm.sh && npm install -g zx" 2>&1

# composer
WORKDIR /home/vscode/.composer
RUN chown vscode: /home/vscode/.composer
USER vscode
RUN echo '{"require":{"squizlabs/php_codesniffer":"^3.7","phpmd/phpmd":"^2.13","friendsofphp/php-cs-fixer":"^3.13"}}' > composer.json \
    && composer global install

WORKDIR /workspaces
EXPOSE 80
EXPOSE 8080

CMD [ "code", "tunnel", "--accept-server-license-terms" ]