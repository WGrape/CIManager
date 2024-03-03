<p align="center">
<img width="321" alt="image" src="https://user-images.githubusercontent.com/35942268/188274226-5ccdfb75-5bcb-4d90-895f-4190d64ae22d.png">
</p>

<div align="center">
<p>A lightweight open source framework for efficiently managing common CI for multi projects</p>
<p>一个用于高效管理多个项目通用CI/CD的轻量级开源框架 | <a href="https://wgrape.github.io/CIManager/">官方网站</a></p>
</div>

<p align="center">
  <a href="https://www.oscs1024.com/project/oscs/WGrape/CIManager?ref=badge_small" alt="OSCS Status"><img src="https://www.oscs1024.com/platform/badge/WGrape/CIManager.svg?size=small"/></a>
    <img src="https://img.shields.io/badge/Language-Shell-blue.svg">
    <img src="https://img.shields.io/badge/Release-1.1.0-blue.svg">
    <img src="https://img.shields.io/github/repo-size/wgrape/cimanager">
    <!--<img src="https://img.shields.io/github/downloads/wgrape/cimanager/total">-->
    <img src="https://img.shields.io/badge/Document-中文-orange.svg">
    <img src="https://img.shields.io/badge/License-MIT-green.svg">   
</p>

## 一、介绍
在微服务下，每一个项目仓库都需要维护独立的```CI/CD```，一旦```CI/CD```有设计升级或变更，所有仓库都需要配合做联动性调整，维护成本极高。

为了解决这个问题，曾经提出过一种方案，详细请见文章 [《多项目下CI管理方案的设计与实现》](https://github.com/WGrape/Blog/issues/249) 。

本项目是基于文章中的```远程管理```方案设计而实现的一个用于高效管理多个项目通用CI的轻量级开源框架，它不但完全开箱即用，而且方便定制化开发与扩展。

## 二、快速上手

> 您可以参考 [apimock-example](https://jihulab.com/WGrape/apimock-example/) 和 [matching](https://github.com/WGrape/matching) 项目是如何在```gitlab```和```github```中使用的

### 1、为您的项目添加ci.yml文件

首先，和单项目下的CI管理方式一样，在您的各个项目下添加一个```.gitlab-ci.yml```或```.github/workflows/.github-ci.yml```配置文件。在```/template```目录下有定义好的配置文件，您可以直接使用。

<img width="300" src="https://github.com/WGrape/CIManager/assets/35942268/21026799-c865-4534-9342-8954cec04200">

### 2、正常提交您的项目
添加完之后，如往常一样，正常编写并提交您的项目即可

### 3、CIManager开始工作
当您每次提交项目的时候，在runner机器上都会运行CIManager，它的底层[运行原理](https://github.com/WGrape/Blog/issues/249)如下图所示，详细运行过程可以 [查看这里](https://jihulab.com/WGrape/apimock-example/-/pipelines)

<img src="https://user-images.githubusercontent.com/35942268/184865495-ca6b8491-6f23-4db6-80c8-9853f677dacb.png" height="400">

## 三、更多文档

- [1. 使用文档](./doc/USAGE.md)
- [2. 设计文档](./doc/DESIGN.md)
- [3. 常见问题](./doc/QA.md)

## 四、私有化部署

### 1、下载项目

无需任务复杂安装过程，直接通过Git方式clone到本地即可。

```bash
git clone https://github.com/WGrape/CIManager.git
```

### 2、部署至私有仓库
如果您不需要对```CIManager```框架进行扩展开发，那么直接把它提交至您的私有仓库，并在您各个项目中的```.gitlab-ci.yml```或```.github/workflows/.github-ci.yml```配置文件中的```https://github.com/WGrape/CIManager.git```替换为CIManager在您私有仓库中的地址即可。

### 3、自定义开发
本框架源码轻量简单，如果不满足您的需求，您可以在```CIManager```框架基础上进行自定义开发，比如新增配置检查、依赖检查等丰富和加强```CI/CD```的流水线功能。具体请参考[设计文档文档](./doc/DESIGN.md)

## 五、贡献

欢迎大家的参与，如果在您使用过程中遇到任何问题，可以随时在 [ISSUE](https://github.com/WGrape/CIManager/issues) 中提问，也欢迎大家的 [PR](https://github.com/WGrape/CIManager/pulls) 对本项目优化。

- [WGrape/matching](https://github.com/WGrape/matching) ：基于CIManager实现在github上对CI/CD的统一管理
- [apimock-example](https://jihulab.com/WGrape/apimock-example/) ：基于CIManager实现在gitlab上对CI/CD的统一管理

<img src="https://contrib.rocks/image?repo=wgrape/cimanager" >
