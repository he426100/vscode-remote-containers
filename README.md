# vscode使用Remote-Containers实现docker-php开发环境

1. wsl下git clone
2. 用vscode打开文件夹：vscode-remote-containers/php/
3. 按f1，选择 remote-containers: Open Folder in Container (Rebuild and Reopen in Container)

### 安装扩展示例
```
# install event
# docker-php-source extract
sudo apt update
sudo apt install libevent-dev -y
pecl install event
docker-php-ext-enable event
```

> [https://code.visualstudio.com/docs/remote/containers](https://code.visualstudio.com/docs/remote/containers)
> [https://code.visualstudio.com/docs/remote/devcontainerjson-reference](https://code.visualstudio.com/docs/remote/devcontainerjson-reference)
> [https://github.com/microsoft/vscode-dev-containers/blob/main/containers/php/](https://github.com/microsoft/vscode-dev-containers/blob/main/containers/php/)
