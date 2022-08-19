# CIManager
An efficient tool for managing CI of multiple gitlab golang projects / 一个适用管理多个gitlab golang项目CI的高效工

## 一、介绍
本项目背景是解决多项目下的CI管理问题，为了解决这个问题，本方案设计并实现了多种方案。详细背景介绍和解决方案请见文章 [《多项目下CI管理方案的设计与实现》](https://github.com/WGrape/Blog/issues/249) 。

由于业务各不相同，本项目无法提供一种完全开箱可用的通用方案。所以只能基于设计的方案，搭建出理想下```CIManager```项目的骨架，具体逻辑内容需要自己实现。

## 二、下载
通过Git方式clone下载完后，将目录中的各个文件自行修改即可。

```bash
git clone https://github.com/WGrape/CIManager.git
cd CIManager
```

## 三、使用

### 1、本地管理
如果选择本地管理方式，通过以下命令把```CIManager```通用CI项目中的各个文件拷贝到不同项目中即可

```bash
bash local_mgr.sh fastcopy ${sourceDir} ${targetDir} 
```

### 2、远程管理
如果选择远程管理方式，只需要各个项目下使用一个类似如下的```.gitlab-ci.yml```文件即可

```yaml
image: golang:1.17
variables:
  PROJECT_NAME: {{PROJECT_NAME}}

before_script:
  - echo '====== CI Start Running ========='
  - cd /temp && git clone git.xxx.com/xxx/CIManager && cd CIManager && cp -r . /yourproject && cd /yourproject && bash remote_mgr.sh runci

after_script:
  - echo '====== CI Stopped Successfully ========='
```
