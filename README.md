# CIManager
A lightweight open source framework for efficiently managing common CI for multiple gitlab golang projects / 一个用于高效管理多个```gitlab golang```项目通用CI的轻量级开源框架

## 一、介绍
在微服务下，每一个项目仓库都需要维护独立的CI/CD，一旦CI/CD有设计升级或变更，所有仓库都需要配合做联动性调整，维护成本极高。

为了解决这个问题，曾经提出过一种方案，详细请见文章 [《多项目下CI管理方案的设计与实现》](https://github.com/WGrape/Blog/issues/249) 。

本项目是基于文章中的```远程管理```方案设计而实现的一个用于高效管理多个```gitlab golang```项目通用CI的轻量级开源框架，它不但完全开箱即用，而且方便定制化开发与扩展。

## 二、如何使用

> 为了方便您快速应用，可以参考 [apimock-example](https://jihulab.com/WGrape/apimock-example/-/jobs) 项目是如何使用```CIManager```的

### 1、为您的项目添加.gitlab-ci.yml文件
在您的各个项目下添加一个```.gitlab-ci.yml```配置文件，它的内容如下所示

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

### 2、正常提交您的项目
如往常一样，正常编写并提交您的项目即可

### 3、CIManager开始工作
当您每次提交项目的时候，在runner机器上都会运行CIManager，如下图所示

<img src="https://user-images.githubusercontent.com/35942268/184865495-ca6b8491-6f23-4db6-80c8-9853f677dacb.png" height="600px">

## 三、私有化部署

### 1、下载项目

无需任务复杂安装过程，直接通过Git方式clone到本地即可。

```bash
git clone https://github.com/WGrape/CIManager.git
```

### 2、部署至私有gitlab
如果您不需要对```CIManager```框架进行扩展开发，那么直接把它提交至您的私有仓库，并在您各个项目中的```.gitlab-ci.yml```配置文件中的```https://github.com/WGrape/CIManager.git```替换为您私有仓库地址即可。
