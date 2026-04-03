# 构建阶段
FROM node:20-alpine AS build-stage

# 设置工作目录
WORKDIR /app

# 复制 package.json 和 package-lock.json
COPY package*.json ./

# 安装依赖
RUN npm install

# 复制项目文件
COPY . .

# 构建 H5 版本
RUN npm run build:h5

# 生产阶段
FROM nginx:alpine AS production-stage

# 复制自定义 nginx 配置
COPY nginx.conf /etc/nginx/nginx.conf

# 复制构建产物到 Nginx 目录（UniApp H5 构建输出目录是 dist/build/h5）
COPY --from=build-stage /app/dist/build/h5 /usr/share/nginx/html

# 修复权限
RUN chmod -R 755 /usr/share/nginx/html

# 暴露端口
EXPOSE 80

# 启动 Nginx
CMD ["nginx", "-g", "daemon off;"]
