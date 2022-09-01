# 帮助文档

## 一、常见问题

### 1、如何安装golangci-lint
官方提供了如下的安装方式

```bash
curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(go env GOPATH)/bin v1.46.2
```

由于官方安装可能会有网络限制，所以在CIManager中使用了基于 [第三方缓存](https://github.com/WGrape/cache) 的安装

## 二、附录参考文档
下面提供了一些可供您使用的参考文档

- [Gitlab Wiki API](https://docs.gitlab.cn/jh/api/wikis.html)
- [极狐WikiAPI](https://docs.gitlab.cn/jh/api/wikis.html)