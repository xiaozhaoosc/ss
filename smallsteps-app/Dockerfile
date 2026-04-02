# 构建阶段
FROM swr.cn-north-4.myhuaweicloud.com/ddn-k8s/docker.io/library/node:20-alpine AS build-stage

# 设置工作目录
WORKDIR /app

# 复制 package.json 相关文件
COPY package*.json ./

# 设置镜像并安装依赖
RUN npm config set registry https://registry.npmmirror.com && npm install

# 复制项目文件
COPY . .

# 构建 H5 版本
RUN npm run build:h5

# 运行阶段
FROM swr.cn-north-4.myhuaweicloud.com/ddn-k8s/docker.io/library/nginx:alpine AS production-stage

# 复制构建产物
COPY --from=build-stage /app/dist/build/h5 /usr/share/nginx/html

# 复制 Nginx 配置
COPY nginx.conf /etc/nginx/nginx.conf

# 设置权限
RUN chmod -R 755 /usr/share/nginx/html

# 暴露端口
EXPOSE 80

# 启动 Nginx
CMD ["nginx", "-g", "daemon off;"]
