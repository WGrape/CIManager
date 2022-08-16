# CIManager
An efficient tool for managing CI of multiple gitlab golang projects / 一个适用管理多个gitlab golang项目CI的高效工

## 一、背景介绍
在团队开发中，工作并不只是分而治之，而是分、治以及集成。基于CI可以实现强大且深度定制的服务自动化，现在已经越来越多的团队开始重视并投入到CI建设的工作中。

大部分公司的CI建设是基于```Gitlab CI```，在项目根目录下创建```.gitlab-ci.yml```文件即可简单快速的实现，项目结构如下所示

```txt
- .gitlab
-    check_code.sh
-    unit_test.sh
- cmd
-    app
- api
-    define
- service
-    AService
-    BService
- .gitignore
- .gitlab-ci.yml
```

在单体架构下，上面这种基于单项目下的CI建设没有任何问题。但是在微服务架构下，就会遇到非常棘手的多项目下CI管理的问题。

由于微服务架构下，一套代码被划分到多个代码库中，多个代码库下都有自己CI代码，一旦CI整体流程需要变动，那么所有项目都要配合修改，造成的整体联动调整过大。

所以本项目会设计并实现一种简单易用的方式，以解决微服务架构下多项目的CI管理问题。

## 二、设计方案

### 1、本地管理
本地管理的设计思想是基于快拷贝。即仍然使用单项目下的CI代码，但是远程的一个仓库中会存储所有项目通用的CI代码。

![image](https://user-images.githubusercontent.com/35942268/184834545-75e95b1c-ec13-40b0-a50d-85b491a9e46d.png)

当每次需要变动的时候，都会把远程通用的CI代码拷贝到本地各个单项目中，然后本地的各个项目再单独修改并提交，完成CI的执行。

![image](https://user-images.githubusercontent.com/35942268/184864108-963434d4-b125-46c0-a404-cf8796bddb64.png)

### 2、远程管理
远程管理的设计思想是基于```WORA```，即```write once, run anywhere（一次编写，到处运行）```。

![image](https://user-images.githubusercontent.com/35942268/184865495-ca6b8491-6f23-4db6-80c8-9853f677dacb.png)

#### (1) 一次编写
只维护一套通用的CI代码```CIManager```

#### (2) 到处运行
每个代码库只需要有自己的一个```.gitlab-ci.yml```文件，且这个文件内容会保持精简而通用，如下所示

```yaml
image: golang:1.17

variables:
  PROJECT_NAME: "test"

before_script:
  - cd /home && git pull git.xxx.com/xxx/CIManager && cd CIManager && bash start.sh
```

当提交代码时，在远程的Runner机器上，会自动拉取```CIManager```代码库并运行```start.sh```脚本，完成CI的执行。
