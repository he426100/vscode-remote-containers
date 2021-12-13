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
    && docker-php-ext-install bcmath gd gettext intl mysqli pcntl pdo_mysql sockets sysvsem xmlwriter xmlrpc xsl zip \
    && a2enmod rewrite && a2enmod headers \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# Install redis
RUN pecl install redis \
    && echo "extension=$(find /usr/local/lib/php/extensions/ -name redis.so)" > /usr/local/etc/php/conf.d/redis.ini \
    && rm -rf /tmp/pear

# [Optional] Uncomment this line to install global node packages.
RUN su vscode -c "source /usr/local/share/nvm/nvm.sh && npm install -g zx" 2>&1

# composer
USER vscode
WORKDIR /home/vscode/.composer
RUN echo '{"require":{"squizlabs/php_codesniffer":"^3.5","phpmd/phpmd":"^2.9","friendsofphp/php-cs-fixer":"^2.16","slince/composer-registry-manager":"^2.0"}}' > composer.json \
    && composer global install
