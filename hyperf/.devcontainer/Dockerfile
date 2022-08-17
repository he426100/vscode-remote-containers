# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.209.3/containers/php/.devcontainer/base.Dockerfile

# [Choice] PHP version (use -bullseye variants on local arm64/Apple Silicon): 8, 8.1, 8.0, 7, 7.4, 7.3, 8-bullseye, 8.1-bullseye, 8.0-bullseye, 7-bullseye, 7.4-bullseye, 7.3-bullseye, 8-buster, 8.1-buster, 8.0-buster, 7-buster, 7.4-buster
ARG VARIANT="8.0-bullseye"
FROM mcr.microsoft.com/vscode/devcontainers/php:0-${VARIANT}

# [Choice] Node.js version: none, lts/*, 16, 14, 12, 10
ARG NODE_VERSION="none"
RUN if [ "${NODE_VERSION}" != "none" ]; then su vscode -c "umask 0002 && . /usr/local/share/nvm/nvm.sh && nvm install ${NODE_VERSION} 2>&1"; fi

# [Optional] Uncomment this section to install additional OS packages.
# swoole
ENV DEBIAN_FRONTEND noninteractive
ENV TERM            xterm-color

ARG DEV_MODE
ENV DEV_MODE $DEV_MODE

COPY rootfilesystem/ /

RUN \
    mv /usr/local/etc/php/conf.d/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini-suggested && \
    curl -sfL https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer && \
    chmod +x /usr/bin/composer                                                                     && \
    apt-get update              && \
    apt-get install -y             \
        inotify-tools              \
        libcurl4-openssl-dev       \
        libpq-dev                  \
        libssl-dev                 \
        supervisor                 \
        unzip                      \
        zlib1g-dev                 \
        --no-install-recommends && \
    install-swoole.sh master \
        --enable-http2        \
        --enable-mysqlnd      \
        --enable-swoole-pgsql \
        --enable-openssl      \
        --enable-sockets --enable-swoole-curl --enable-swoole-json && \
    mkdir -p /var/log/supervisor && \
    docker-php-ext-install bcmath mysqli pdo_mysql pcntl && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* $HOME/.composer/*-old.phar /usr/bin/qemu-*-static

# Install redis
RUN set -ex \
    && pecl update-channels \
    && pecl install redis \
    && docker-php-ext-enable redis \
    && rm -rf /tmp/pear

# hyperf
##
# ---------- env settings ----------
##
# --build-arg timezone=Asia/Shanghai
ARG timezone

ENV TIMEZONE=${timezone:-"Asia/Shanghai"}

# update
RUN set -ex \
    # show php version and extensions
    && php -v \
    && php -m \
    && php --ri swoole \
    #  ---------- some config ----------
    && cd /usr/local/etc/php/ \
    # - config PHP
    && { \
        echo "upload_max_filesize=128M"; \
        echo "post_max_size=128M"; \
        echo "memory_limit=1G"; \
        echo "date.timezone=${TIMEZONE}"; \
        echo "swoole.use_shortname = 'Off'"; \
    } | tee conf.d/99_overrides.ini \
    # - config timezone
    && ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
    && echo "${TIMEZONE}" > /etc/timezone \
    # ---------- clear works ----------
    && echo -e "\033[42;37m Build Completed :).\033[0m\n"

# [Optional] Uncomment this line to install global node packages.
RUN su vscode -c "source /usr/local/share/nvm/nvm.sh && npm install -g zx" 2>&1

# composer global
USER vscode
WORKDIR /home/vscode/.composer
RUN echo '{"require":{"squizlabs/php_codesniffer":"^3.5","phpmd/phpmd":"^2.9","friendsofphp/php-cs-fixer":"^2.16","slince/composer-registry-manager":"^2.0"}}' > composer.json \
    && composer global install

WORKDIR /workspaces