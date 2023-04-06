# base node image
FROM node:16-bullseye-slim as base

# 为Prisma安装openssl依赖
# 如果你需要Prisma依赖，请取消打开一下命令行
# RUN apt-get update && apt-get install -y openssl

# 为base镜像设置环境变量
ENV NODE_ENV=production

# 用于安装npm包
FROM base as deps

RUN mkdir /app
WORKDIR /app

ADD package.json package-lock.json ./
# 这里我们使用淘宝提供的国内镜像加速
RUN npm install --production=false --registry=https://registry.npmmirror.com/

# 用于设置运行环境依赖
FROM base as production-deps

RUN mkdir /app
WORKDIR /app

COPY --from=deps /app/node_modules /app/node_modules
ADD package.json package-lock.json ./
RUN npm prune --production

# 用于构建应用
FROM base as build

RUN mkdir /app
WORKDIR /app

COPY --from=deps /app/node_modules /app/node_modules
ENV NODE_ENV=production

# 添加Prisma
# 如果你需要Prisma依赖，请取消打开一下命令行
# RUN npx prisma generate

ADD . .
RUN npm run build

# 最后，构建部署镜像
FROM base

ENV NODE_ENV=production

RUN mkdir /app
WORKDIR /app

COPY --from=production-deps /app/node_modules /app/node_modules
# 如果你需要Prisma依赖，请取消打开一下命令行
#COPY --from=build /app/node_modules/.prisma /app/node_modules/.prisma
COPY --from=build /app/build /app/build
COPY --from=build /app/public /app/public
ADD . .

CMD ["node", "server.js"]