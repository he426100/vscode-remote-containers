# vscode使用Remote-Containers实现docker-php开发环境

1. 根据 [https://code.visualstudio.com/docs/remote/containers](https://code.visualstudio.com/docs/remote/containers "https://code.visualstudio.com/docs/remote/containers") 新建一份容器配置 （先建一个专门放容器配置的文件夹，然后在wsl中打开，然后创建容器，比如 ~/vscode-containers/php）

2. devcontainer.json
```
// For format details, see https://aka.ms/devcontainer.json. For config options, see the README at:
// https://github.com/microsoft/vscode-dev-containers/tree/v0.209.3/containers/php
{
	"name": "PHP",
	"build": {
		"dockerfile": "Dockerfile",
		"args": { 
			// Update VARIANT to pick a PHP version: 8, 8.1, 8.0, 7, 7.4
			// Append -bullseye or -buster to pin to an OS version.
			// Use -bullseye variants on local on arm64/Apple Silicon.
			"VARIANT": "7",
			"NODE_VERSION": "lts/*"
		}
	},
	
	// Set *default* container specific settings.json values on container create.
	"settings": { 
		"php.validate.executablePath": "/usr/local/bin/php"
	},

	// Add the IDs of extensions you want installed when the container is created.
	"extensions": [
		"felixfbecker.php-debug",
		"bmewburn.vscode-intelephense-client",
		"mrmlnc.vscode-apache"
	],

	// Use 'forwardPorts' to make a list of ports inside the container available locally.
	"forwardPorts": [8080],

	// Use 'postCreateCommand' to run commands after the container is created.
	// "postCreateCommand": "sudo chmod a+x \"$(pwd)\" && sudo rm -rf /var/www/html && sudo ln -s \"$(pwd)\" /var/www/html"

	// Comment out connect as root instead. More info: https://aka.ms/vscode-remote/containers/non-root.
	"remoteUser": "vscode",
	"features": {
		"git": "latest"
	},

   // 绑定wsl ~/git  /etc/apache2/site-enabled到容器
	"mounts": [
		"source=${localEnv:HOME}${localEnv:USERPROFILE}/git,target=/workspaces/git,type=bind,consistency=cached",
		"source=/etc/apache2/sites-enabled,target=/etc/apache2/sites-enabled,type=bind,consistency=cached"
	],

	"runArgs": ["-p=80:80"],

	"shutdownAction": "none"
}
```

3. Dockerfile
```
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
```

4. 安装扩展示例
```
# install event
docker-php-source extract
sudo apt update
sudo apt install libevent-dev -y
pecl install event
docker-php-ext-enable event
```

总结：在官方基础上编译常用扩展、绑定wsl下git目录、绑定80端口
> [https://github.com/microsoft/vscode-dev-containers/blob/main/containers/php/](https://github.com/microsoft/vscode-dev-containers/blob/main/containers/php/ "https://github.com/microsoft/vscode-dev-containers/blob/main/containers/php/")
> [https://code.visualstudio.com/docs/remote/devcontainerjson-reference](https://code.visualstudio.com/docs/remote/devcontainerjson-reference "https://code.visualstudio.com/docs/remote/devcontainerjson-reference")