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

# Copy build artifacts from build stage
COPY --from=build-stage /app/dist /usr/share/nginx/html

# Fix permissions for Nginx
RUN chmod -R 755 /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Nginx config will be mounted or copied via docker-compose
CMD ["nginx", "-g", "daemon off;"]
