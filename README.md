<p align="center">
<img width="321" alt="image" src="https://user-images.githubusercontent.com/35942268/188274226-5ccdfb75-5bcb-4d90-895f-4190d64ae22d.png">
</p>

<div align="center">
<p>A lightweight open source framework for efficiently managing common CI for multi projects</p>
<p>一个用于高效管理多个项目通用CI的轻量级开源框架 | <a href="https://wgrape.github.io/CIManager/">官方网站</a></p>
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

- [一、介绍](#1)
- [二、快速上手](#2)
- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[1、为您的项目添加x-ci.yml文件](#21)
- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[2、正常提交您的项目](#22)
- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[3、CIManager开始工作](#23)
- [三、CI/CD配置](#3)
- [四、私有化部署](#4)
- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[1、下载项目](#41)
- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[2、部署至私有仓库](#42)
- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[3、自定义扩展](#43)
- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[4、多语言支持](#44)
- [五、帮助文档](#5)
- [六、贡献榜](#6)

## <span id="1">一、介绍</span>
在微服务下，每一个项目仓库都需要维护独立的```CI/CD```，一旦```CI/CD```有设计升级或变更，所有仓库都需要配合做联动性调整，维护成本极高。

为了解决这个问题，曾经提出过一种方案，详细请见文章 [《多项目下CI管理方案的设计与实现》](https://github.com/WGrape/Blog/issues/249) 。

本项目是基于文章中的```远程管理```方案设计而实现的一个用于高效管理多个项目通用CI的轻量级开源框架，它不但完全开箱即用，而且方便定制化开发与扩展。

## <span id="2">二、快速上手</span>

> 1、在```CIManager```的早期版本中仅支持```gitlab```项目，但在 [v1.3.0](https://github.com/WGrape/CIManager/releases/tag/v1.3.0) 版本后新增了对```github```项目的支持。
> 
> 2、为了方便您快速应用，可以参考 [apimock-example](https://jihulab.com/WGrape/apimock-example/) 和 [matching](https://github.com/WGrape/matching) 项目是如何在```gitlab```和```github```中使用```CIManager```进行```CI/CD```管理的

### <span id="21">1、为您的项目添加x-ci.yml文件</span>

> 如果您使用的github项目，需要创建```.github/workflows/.github-ci.yml```配置文件。如果您使用的gitlab项目，需要创建```.gitlab-ci.yml```配置文件。

首先，和单项目下的CI管理方式一样，在您的各个项目下添加一个```.gitlab-ci.yml```或```.github/workflows/.github-ci.yml```配置文件，它的内容如下所示

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
    # 注意如果是github项目, 则需要使用 bash start.sh github
    - git clone https://github.com/wgrape/CIManager.git ; cp -an ./CIManager/. ./ ; rm -rf ./CIManager ; bash start.sh gitlab
```

### <span id="22">2、正常提交您的项目</span>
添加完之后，如往常一样，正常编写并提交您的项目即可

### <span id="23">3、CIManager开始工作</span>
当您每次提交项目的时候，在runner机器上都会运行CIManager，它的底层[运行原理](https://github.com/WGrape/Blog/issues/249)如下图所示，详细运行过程可以 [查看这里](https://jihulab.com/WGrape/apimock-example/-/jobs/4354428)

<img src="https://user-images.githubusercontent.com/35942268/184865495-ca6b8491-6f23-4db6-80c8-9853f677dacb.png" height="600px">

## <span id="3">三、CI/CD配置</span>
基于低耦合、易扩展、高效率的思想，CIManager框架内部集成了非常丰富的Stage，通过不同Stage的组合构成了一个完整的集成和发布流程。

<img width="491" alt="image" src="https://user-images.githubusercontent.com/35942268/188272087-7e502181-4c4e-4342-8124-7dae22ddbfd9.png">

那么是如何实现的呢？在 [apimock-example](https://jihulab.com/WGrape/apimock-example/-/blob/main/.gitlab-ci.yml) 项目例子中，会发现定义了大量的```variables```变量，正是这些变量被应用于不同的Stage，才实现了强大丰富的```CI/CD```功能。

默认情况下，即使不配置任何变量，也可以正常使用部分功能。如果您想要了解更多```CI/CD```的配置，请[查看文档](./doc/README.md#1)

## <span id="4">四、私有化部署</span>

### <span id="41">1、下载项目</span>

无需任务复杂安装过程，直接通过Git方式clone到本地即可。

```bash
git clone https://github.com/WGrape/CIManager.git
```

### <span id="42">2、部署至私有仓库</span>
如果您不需要对```CIManager```框架进行扩展开发，那么直接把它提交至您的私有仓库，并在您各个项目中的```.gitlab-ci.yml```或```.github/workflows/.github-ci.yml```配置文件中的```https://github.com/WGrape/CIManager.git```替换为CIManager在您私有仓库中的地址即可。

### <span id="43">3、自定义扩展</span>
本框架源码轻量简单，如果不满足您的需求，您可以在```CIManager```框架基础上进行自定义扩展的开发。 

当然也可以新增配置检查、依赖检查等加强```CI/CD```的阶段（Stage）操作，直接修改源码即可。具体请参考[设计原理文档](./doc/design.md)

### <span id="44">4、多语言支持</span>
虽然本项目以```golang```语言为例，但是您只需要简单修改源码，即可实现任何语言多项目的CI/CD统一管理。

## <span id="5">五、问题与解答</span>
如果在您使用过程中遇到问题，可以查看[官方文档](./doc/README.md)，或在```ISSUE```中提问。

## <span id="6">六、贡献与使用榜</span>

<img src="https://contrib.rocks/image?repo=wgrape/cimanager" >

- [WGrape/matching](https://github.com/WGrape/matching) ：基于CIManager实现在github上对CI/CD的统一管理
- [apimock-example](https://jihulab.com/WGrape/apimock-example/) ：基于CIManager实现在gitlab上对CI/CD的统一管理
