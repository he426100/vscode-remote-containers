# vscode使用Remote-Containers实现docker-php开发环境

### 使用说明
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

### 准备和问题
1. 安装好wsl2及docker
2. `mkdir ~/git` 存放源代码，挂载到容器内/workspaces/git，实现容器销毁后保留代码
3. `mkdir -p /etc/apache2/sites-enabled`，存放apache站点配置，挂载到容器内/etc/apache2/sites-enabled，实现容器销毁后保存站点配置
4. 可能会出现Open in Container失败（构建镜像失败），多半是网络问题，把Proxifier开起来就行了

### 其他
1. [wsl2自动启动服务并且自动更新hosts文件里的ip](https://my.oschina.net/u/2266306/blog/4561599)
2. [解决WSL2中Vmmem内存占用过大问题](https://my.oschina.net/u/2266306/blog/4680942)
3. [wsl2使用docker实现开机自启redis,mysql](https://my.oschina.net/u/2266306/blog/5354632)

### 参考资料
> [https://code.visualstudio.com/docs/remote/containers](https://code.visualstudio.com/docs/remote/containers)
> [https://code.visualstudio.com/docs/remote/devcontainerjson-reference](https://code.visualstudio.com/docs/remote/devcontainerjson-reference)
> [https://github.com/microsoft/vscode-dev-containers/blob/main/containers/php/](https://github.com/microsoft/vscode-dev-containers/blob/main/containers/php/)
