# Build arguments
ARG DOCKER_IMAGE_PREFIX

# Build stage
FROM swr.cn-north-4.myhuaweicloud.com/ddn-k8s/docker.io/node:20-alpine AS build-stage

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm config set registry https://registry.npmmirror.com && npm install

# Copy project files
COPY . .

# Build the project
RUN npm run build:prod

# Production stage
FROM swr.cn-north-4.myhuaweicloud.com/ddn-k8s/docker.io/nginx:alpine AS production-stage

# 关键：将构建产物放到子目录下以匹配 VITE_APP_CONTEXT_PATH
COPY --from=build-stage /app/dist /usr/share/nginx/html/webadminss/

# 复制自定义 Nginx 配置
COPY nginx.conf /etc/nginx/nginx.conf

# Fix permissions
RUN chmod -R 755 /usr/share/nginx/html

# Expose port 80
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
