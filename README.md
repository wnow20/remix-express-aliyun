# Remix-express-aliyun

欢迎访问本项目 :tada: ，本项目用于说明如何部署Aliyun FC(Serverless)，如果你对 Remix 无服务部署的形式感兴趣，请给本仓库点个星 :star:

函数计算是事件驱动的全托管计算服务。使用函数计算，您无需采购与管理服务器等基础设施，只需编写并上传代码或镜像。函数计算为您准备好计算资源，弹性地、可靠地运行任务，并提供日志查询、性能监控和报警等功能。

因此对于独立开发者，再前期没有太多预算的情况下，使用无服务(Serverless)用于部署服务是一种很好的选择，接下来带你了解如果合同自定义容器镜像部署阿里云函数FC。

项目使用 Remix 官方提供的脚手架生成工具 `npx create-remix@latest` 生成，后端服务基于Express，便于拓展，方便自定义功能。

## 如何使用本项目
0. 参考 [本项目教程](https://goworks.vercel.app/blog/remix-express-deploy-aliyun.html)，对项目有个大概了解
1. 克隆项目代码
2. 开发
3. 打镜像
4. 部署

## 开发


```sh
npm run dev
```

## 打包并运行

```sh
npm run build
```


```sh
npm start
```

## 部署

```shell
# 打镜像
docker build . -t remix-express-aliyun:latest

# 部署镜像
docker run --rm -it -p 9000:9000 remix-express-aliyun:latest
```
