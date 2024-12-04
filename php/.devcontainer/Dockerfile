# [Choice] PHP version: https://mcr.microsoft.com/v2/devcontainers/php/tags/list
ARG VARIANT="7.4-apache-bullseye"
FROM mcr.microsoft.com/devcontainers/php:0-${VARIANT}

# [Choice] Node.js version: none, lts/*, 16, 14, 12, 10
ARG NODE_VERSION="none"
RUN if [ "${NODE_VERSION}" != "none" ]; then su vscode -c "umask 0002 && . /usr/local/share/nvm/nvm.sh && nvm install ${NODE_VERSION} 2>&1"; fi

# [Optional] Uncomment this section to install additional OS packages.
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends libgd-dev libxslt1-dev libzip-dev libxml2-dev zip \
    && docker-php-ext-install bcmath gd gettext intl mysqli pcntl pdo_mysql sockets sysvsem xmlwriter xsl zip \
    && a2enmod rewrite && a2enmod headers \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# Install redis
RUN set -ex \
    && pecl update-channels \
    && pecl install redis \
    && docker-php-ext-enable redis \
    && rm -rf /tmp/pear

# [Optional] Uncomment this line to install global node packages.
# RUN su vscode -c "source /usr/local/share/nvm/nvm.sh && npm install -g zx" 2>&1

# composer
USER vscode
WORKDIR /home/vscode/.composer
RUN echo '{"require":{"squizlabs/php_codesniffer":"^3.7","phpmd/phpmd":"^2.13","friendsofphp/php-cs-fixer":"^3.13"}}' > composer.json \
    && composer global install

WORKDIR /workspaces