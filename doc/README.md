# 官方文档

## <span id="1">一、CI/CD配置</span>

### 1、系统变量
下面是所支持的系统级别的变量

| 变量名 | 必须  | 含义    | 备注 |
| ---- |----|----|----|
| GOPATH | 否   | Go环境配置 | 无  |

### 2、项目变量
下面是所支持的项目级别的变量

| 变量名          | 必须  | 含义    | 备注  |
|--------------|-----|-------|-----|
| PROJECT_NAME | 否   | 项目名称  | 无   |
| PROJECT_ID   | 否   | 项目的ID | 无   |

### 3、阶段变量
下面是在不同阶段（Stage）所支持的变量

#### (1) 单元测试

| 变量名          | 必须  | 含义        | 备注  |
|--------------|-----|-----------|-----|
| UNIT_TEST_TRIGGER_CMD | 否   | 触发单元测试的命令 | 无   |

#### (2) 接口文档生成

| 变量名          | 必须  | 含义                 | 备注  |
|--------------|-----|--------------------|-----|
| APIDOC_TRIGGER_CMD | 否   | 触发生成接口文档的命令        | 无   |
| APIDOC_FILE   | 否   | 生成的接口文档路径          | 无   |
| GITLAB_HOST   | 否   | gitlab私有化部署的域名     | 无   |
| GITLAB_API_TOKEN   | 否   | gitlab配置的API Token | 无   |

#### (3) 本地构建

| 变量名          | 必须  | 含义      | 备注  |
|--------------|-----|---------|-----|
| LOCAL_BUILD_TRIGGER_CMD | 是   | 构建项目的命令 | 无   |

#### (4) 健康检查

| 变量名          | 必须  | 含义             | 备注  |
|--------------|-----|----------------|-----|
| HEALTH_CHECK_TRIGGER_CMD | 是   | 健康检查和检测成功运行的命令 | 无   |
| HEALTH_CHECK_SUCCESS | 是   | 健康检查成功的返回内容    | 无   |

### 4、其他变量
下面是所支持的其它变量

| 变量名          | 必须  | 含义                  | 备注  |
|--------------|-----|---------------------|-----|
| DING_KEYWORD | 否   | 钉钉群通知关键字            | 无   |
| DING_ACCESS_TOKEN   | 否   | 钉钉群通知的WebHook Token | 无   |
| DING_NOTICE_SWITCH | 否   | 是否开启钉钉群通知           | 无   |



## 二、常见问题

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