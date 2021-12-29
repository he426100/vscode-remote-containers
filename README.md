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
1. 安装好[wsl2](https://docs.microsoft.com/zh-cn/windows/wsl/)及[docker](https://docs.microsoft.com/zh-cn/windows/wsl/tutorials/wsl-containers)
2. `mkdir ~/git` 存放源代码，挂载到容器内/workspaces/git，实现容器销毁后保留代码
3. `mkdir -p /etc/apache2/sites-enabled`，存放apache站点配置，挂载到容器内/etc/apache2/sites-enabled，实现容器销毁后保存站点配置
4. 可能会出现Open in Container失败（构建镜像失败），多半是网络问题，把Proxifier开起来就行了
5. 更新npm不生效可以用`su node -c "npm install -g npm"`
6. xdebug和phpcs冲突需要设置xdebug.start_with_request = trigger，命令行下调试需要先执行`export XDEBUG_SESSION=1`，其他调试问题看官方文档[https://xdebug.org/docs/](https://xdebug.org/docs/)

### 其他
1. [wsl2自动启动服务并且自动更新hosts文件里的ip](https://my.oschina.net/u/2266306/blog/4561599)
2. [解决WSL2中Vmmem内存占用过大问题](https://my.oschina.net/u/2266306/blog/4680942)
3. [wsl2使用docker实现开机自启redis,mysql](https://my.oschina.net/u/2266306/blog/5354632)
4. [迁移wsl2到其他盘](https://github.com/pxlrbt/move-wsl)
5. [释放wsl2占用的磁盘空间](https://superuser.com/questions/1606213/how-do-i-get-back-unused-disk-space-from-ubuntu-on-wsl2)

### 参考资料
> [适用于 Linux 的 Windows 子系统文档](https://docs.microsoft.com/zh-cn/windows/wsl/)
> [https://code.visualstudio.com/docs/remote/containers](https://code.visualstudio.com/docs/remote/containers)
> [https://code.visualstudio.com/docs/remote/devcontainerjson-reference](https://code.visualstudio.com/docs/remote/devcontainerjson-reference)
> [https://github.com/microsoft/vscode-dev-containers/blob/main/containers/php/](https://github.com/microsoft/vscode-dev-containers/blob/main/containers/php/)
