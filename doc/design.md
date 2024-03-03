<div align="center"><h1>设计文档</h1></div>

> 文档版本若存在不更新问题，请大家即时在 Issues 中反馈

## 一、架构概览
整个架构是基于变量驱动的CI/CD组成式的流水线设计，CI/CD由多个Stage组成，每个Stage内部又有多个不同的job组成。

整个项目都是基于变量配置的，也就是说我们只需要按要求配置好需要的变量，即可正常驱动起job的运行，进而控制整个CI/CD流水线。

<img width="1000" alt="image" src="https://github.com/WGrape/CIManager/assets/35942268/2c649b2b-371e-469e-b245-c37c9d9453a2">
