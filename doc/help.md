# 帮助文档

## 一、常见问题

### 1、如何安装golangci-lint
官方提供了如下的安装方式

```bash
curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(go env GOPATH)/bin v1.46.2
```

由于官方安装可能会有网络限制，所以在CIManager中使用了基于 [第三方缓存](https://github.com/WGrape/cache) 的安装

### 2、CURL: command not found问题
在Ubuntu系统下，使用```apt-get```安装```curl```即可。特别需要注意的是。如果没有特殊兼容处理是无法使用```CURL```这种大写拼写命令的，需要使用小写的```curl```命令

```bash
mv /etc/apt/sources.list /etc/apt/sources.list.bak \
    && echo 'deb http://mirrors.163.com/debian/ stretch main non-free contrib' > /etc/apt/sources.list \
    && echo 'deb http://mirrors.163.com/debian/ stretch-updates main non-free contrib' >> /etc/apt/sources.list \
    && echo 'deb http://mirrors.163.com/debian-security/ stretch/updates main non-free contrib' >> /etc/apt/sources.list \
    && apt-get update -y
apt-get install curl -y
```

## 二、附录参考文档
下面提供了一些可供您使用的参考文档

- [Gitlab Wiki API](https://docs.gitlab.cn/jh/api/wikis.html)
- [极狐WikiAPI](https://docs.gitlab.cn/jh/api/wikis.html)