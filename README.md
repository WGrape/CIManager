# CIManager
A lightweight open source framework for efficiently managing common CI for multiple gitlab golang projects / 一个用于高效管理多个```gitlab golang```项目通用CI的轻量级开源框架

- [一、介绍](#1)
- [二、如何使用](#2)
- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[1、为您的项目添加.gitlab-ci.yml文件](#21)
- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[2、正常提交您的项目](#22)
- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[3、CIManager开始工作](#23)
- [三、功能配置](#3)
- [四、私有化部署](#4)
- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[1、下载项目](#41)
- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[2、部署至私有gitlab](#42)
- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[3、扩展开发](#43)
- [五、帮助文档](#5)

## <span id="1">一、介绍</span>
在微服务下，每一个项目仓库都需要维护独立的```CI/CD```，一旦```CI/CD```有设计升级或变更，所有仓库都需要配合做联动性调整，维护成本极高。

为了解决这个问题，曾经提出过一种方案，详细请见文章 [《多项目下CI管理方案的设计与实现》](https://github.com/WGrape/Blog/issues/249) 。

本项目是基于文章中的```远程管理```方案设计而实现的一个用于高效管理多个```gitlab golang```项目通用CI的轻量级开源框架，它不但完全开箱即用，而且方便定制化开发与扩展。

## <span id="2">二、如何使用</span>

> 为了方便您快速应用，可以参考 [apimock-example](https://jihulab.com/WGrape/apimock-example/) 项目是如何使用```CIManager```的

### <span id="21">1、为您的项目添加.gitlab-ci.yml文件</span>
首先，和单项目下的CI管理方式一样，在您的各个项目下添加一个```.gitlab-ci.yml```配置文件，它的内容如下所示

```yaml
image: golang:1.17

before_script:
  - echo '====== CIManager Start Running ========='

after_script:
  - echo '====== CIManager Stopped Successfully ========='

stages:
  - CIManager

CIManager:
  stage: CIManager
  script:
    - git clone https://github.com/wgrape/CIManager.git ; cp -an ./CIManager/. ./ ; rm -rf ./CIManager ; bash start.sh
```

### <span id="22">2、正常提交您的项目</span>
添加完之后，如往常一样，正常编写并提交您的项目即可

### <span id="23">3、CIManager开始工作</span>
当您每次提交项目的时候，在runner机器上都会运行CIManager，它的底层运行原理如下图所示，详细运行过程可以 [查看这里](https://jihulab.com/WGrape/apimock-example/-/jobs/4354428)

<img src="https://user-images.githubusercontent.com/35942268/184865495-ca6b8491-6f23-4db6-80c8-9853f677dacb.png" height="600px">

## <span id="3">三、功能配置</span>
在 [apimock-example](https://jihulab.com/WGrape/apimock-example/-/blob/main/.gitlab-ci.yml) 项目例子中，会发现它定义了一系列的```variables```变量，它们正是用于实现```CI/CD```自定义功能配置的变量。在[设计原理-功能配置](./doc/design.md#1)问中会详细介绍CIManager支持的所有变量。

## <span id="4">四、私有化部署</span>

### <span id="41">1、下载项目</span>

无需任务复杂安装过程，直接通过Git方式clone到本地即可。

```bash
git clone https://github.com/WGrape/CIManager.git
```

### <span id="42">2、部署至私有gitlab</span>
如果您不需要对```CIManager```框架进行扩展开发，那么直接把它提交至您的私有仓库，并在您各个项目中的```.gitlab-ci.yml```配置文件中的```https://github.com/WGrape/CIManager.git```替换为CIManager在您私有仓库中的地址即可。

### <span id="43">3、扩展开发</span>
本框架是基于```gitlab golang```开发的框架，如果您项目中使用的是其他git仓库或语言，那么可以在```CIManager```框架基础上进行扩展开发。

您当然也可以新增配置检查、依赖检查等加强```CI/CD```功能的阶段（Stage）操作，直接修改源码即可。具体请参考[设计原理文档](./doc/design.md)

## <span id="5">五、帮助文档</span>
如果在您使用过程中遇到问题，请参考[帮助文档](./doc/help.md)
