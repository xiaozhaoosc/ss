# 部署指南

## 1. 概述

### 1.1 文档目的
本文档详细描述 Small Steps 系统的部署流程，包括前端、后端、硬件和 AI 中台的部署步骤，确保系统能够正确、安全地部署到生产环境。

### 1.2 部署环境
- **操作系统**：Linux (Ubuntu 20.04+)
- **数据库**：PostgreSQL 14.0+
- **缓存**：Redis 6.0+
- **消息队列**：RabbitMQ 3.8+
- **Web 服务器**：Nginx 1.18+
- **容器化**：Docker 20.04+
- **编排**：Docker Compose

## 2. 后端部署

### 2.1 环境准备
1. **安装 Docker 和 Docker Compose**
   ```bash
   sudo apt update
   sudo apt install docker.io docker-compose
   ```

2. **创建项目目录**
   ```bash
   mkdir -p smallsteps/deploy
   cd smallsteps/deploy
   ```

3. **创建 Docker Compose 配置文件**
   ```yaml
   # docker-compose.yml
   version: '3.8'
   
   services:
     postgres:
       image: postgres:14
       container_name: smallsteps-postgres
       environment:
         POSTGRES_DB: smallsteps
         POSTGRES_USER: smallsteps
         POSTGRES_PASSWORD: your_password
       ports:
         - "5432:5432"
       volumes:
         - postgres_data:/var/lib/postgresql/data
       restart: always
     
     redis:
       image: redis:6
       container_name: smallsteps-redis
       ports:
         - "6379:6379"
       volumes:
         - redis_data:/data
       restart: always
     
     rabbitmq:
       image: rabbitmq:3.8-management
       container_name: smallsteps-rabbitmq
       environment:
         RABBITMQ_DEFAULT_USER: smallsteps
         RABBITMQ_DEFAULT_PASS: your_password
       ports:
         - "5672:5672"
         - "15672:15672"
       volumes:
         - rabbitmq_data:/var/lib/rabbitmq
       restart: always
     
     backend:
       build: ../smallsteps-api
       container_name: smallsteps-backend
       environment:
         SPRING_DATASOURCE_URL: jdbc:postgresql://postgres:5432/smallsteps
         SPRING_DATASOURCE_USERNAME: smallsteps
         SPRING_DATASOURCE_PASSWORD: your_password
         SPRING_REDIS_HOST: redis
         SPRING_RABBITMQ_HOST: rabbitmq
         SPRING_RABBITMQ_USERNAME: smallsteps
         SPRING_RABBITMQ_PASSWORD: your_password
         JWT_SECRET: your_jwt_secret
       ports:
         - "8080:8080"
       depends_on:
         - postgres
         - redis
         - rabbitmq
       restart: always
   
   volumes:
     postgres_data:
     redis_data:
     rabbitmq_data:
   ```

### 2.2 构建和运行
1. **构建后端镜像**
   ```bash
   cd ../smallsteps-api
   docker build -t smallsteps-backend .
   ```

2. **启动服务**
   ```bash
   cd ../deploy
   docker-compose up -d
   ```

3. **初始化数据库**
   ```bash
   docker exec -it smallsteps-postgres psql -U smallsteps -d smallsteps -f /path/to/init.sql
   ```

### 2.3 配置
- **环境变量**：在 `docker-compose.yml` 中配置环境变量
- **应用配置**：在 `application.yml` 中配置应用参数
- **JWT 密钥**：设置安全的 JWT 密钥

## 3. 前端部署

### 3.1 移动应用部署

#### 3.1.1 iOS 部署
1. **构建 iOS 应用**
   ```bash
   cd smallsteps-app
   npm run build:ios
   ```

2. **提交到 App Store**
   - 使用 Xcode 打开构建产物
   - 配置应用信息
   - 提交到 App Store Connect
   - 通过 App Store 审核后发布

#### 3.1.2 Android 部署
1. **构建 Android 应用**
   ```bash
   cd smallsteps-app
   npm run build:android
   ```

2. **提交到 Google Play**
   - 生成签名 APK
   - 登录 Google Play Console
   - 上传 APK
   - 通过审核后发布

### 3.2 管理后台部署
1. **构建管理后台**
   ```bash
   cd smallsteps-ui
   npm install
   npm run build
   ```

2. **部署到 Nginx**
   ```bash
   # 复制构建产物到 Nginx 目录
   sudo cp -r dist/* /var/www/smallsteps-ui/
   
   # 配置 Nginx
   sudo nano /etc/nginx/sites-available/smallsteps-ui
   ```

3. **Nginx 配置**
   ```nginx
   server {
       listen 80;
       server_name admin.smallsteps.com;
       
       root /var/www/smallsteps-ui;
       index index.html;
       
       location / {
           try_files $uri $uri/ /index.html;
       }
       
       location /api {
           proxy_pass http://localhost:8080;
           proxy_set_header Host $host;
           proxy_set_header X-Real-IP $remote_addr;
           proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
           proxy_set_header X-Forwarded-Proto $scheme;
       }
   }
   ```

4. **启用站点**
   ```bash
   sudo ln -s /etc/nginx/sites-available/smallsteps-ui /etc/nginx/sites-enabled/
   sudo nginx -t
   sudo systemctl restart nginx
   ```

## 4. 硬件部署

### 4.1 固件烧录
1. **准备 ESP32-S3 开发板**
2. **安装 MicroPython 固件**
   - 下载 MicroPython 固件
   - 使用 esptool.py 烧录固件
   ```bash
   esptool.py --port /dev/ttyUSB0 erase_flash
   esptool.py --port /dev/ttyUSB0 --baud 460800 write_flash -z 0x0 micropython.bin
   ```

3. **上传代码**
   - 使用 ampy 或 rshell 上传代码
   ```bash
   ampy --port /dev/ttyUSB0 put main.py
   ampy --port /dev/ttyUSB0 put boot.py
   ampy --port /dev/ttyUSB0 put config.py
   # 上传其他必要文件
   ```

### 4.2 网络配置
1. **配置 Wi-Fi**
   - 设备启动后会创建一个 Wi-Fi 热点
   - 连接到该热点
   - 访问 `http://192.168.4.1` 配置 Wi-Fi 信息

2. **配置 MQTT**
   - 在设备配置页面配置 MQTT 服务器信息
   - 包括服务器地址、端口、用户名和密码

### 4.3 设备绑定
1. **打开移动应用**
2. **进入设备管理页面**
3. **点击添加设备**
4. **扫描设备上的二维码**
5. **完成绑定流程**

## 5. AI 中台部署

### 5.1 环境准备
1. **创建 Docker 配置文件**
   ```yaml
   # docker-compose.yml
   version: '3.8'
   
   services:
     ai-service:
       build: ../smallsteps-ai
       container_name: smallsteps-ai
       environment:
         FLASK_APP: app.py
         FLASK_ENV: production
         MODEL_PATH: /app/models
       ports:
         - "5000:5000"
       volumes:
         - model_data:/app/models
       restart: always
   
   volumes:
     model_data:
   ```

### 5.2 构建和运行
1. **构建 AI 服务镜像**
   ```bash
   cd ../smallsteps-ai
   docker build -t smallsteps-ai .
   ```

2. **启动服务**
   ```bash
   cd ../deploy
   docker-compose up -d
   ```

3. **模型部署**
   - 将训练好的模型上传到 `model_data` 卷
   - 重启 AI 服务

## 6. 系统集成

### 6.1 配置 API 地址
- **移动应用**：在 `config.js` 中配置 API 地址
- **管理后台**：在 `.env.production` 中配置 API 地址
- **硬件设备**：在设备配置页面配置 MQTT 服务器地址

### 6.2 测试集成
1. **测试 API 连接**
   ```bash
   curl http://localhost:8080/api/auth/info
   ```

2. **测试设备连接**
   - 检查设备是否在线
   - 测试设备与后端的通信

3. **测试 AI 服务**
   ```bash
   curl -X POST http://localhost:5000/api/ai/breakdown -H "Content-Type: application/json" -d '{"task": "完成作业"}'
   ```

## 7. 监控和日志

### 7.1 监控
- **后端监控**：使用 Prometheus + Grafana 监控后端服务
- **设备监控**：监控设备在线状态和电池电量
- **系统监控**：监控服务器 CPU、内存和磁盘使用情况

### 7.2 日志
- **后端日志**：查看 Docker 容器日志
  ```bash
  docker logs smallsteps-backend
  ```

- **Nginx 日志**：查看 Nginx 访问日志
  ```bash
  sudo tail -f /var/log/nginx/access.log
  ```

- **设备日志**：使用串口查看设备日志
  ```bash
  screen /dev/ttyUSB0 115200
  ```

## 8. 升级和维护

### 8.1 版本升级
1. **后端升级**
   - 停止服务
   - 拉取最新代码
   - 构建新镜像
   - 启动服务

2. **前端升级**
   - 拉取最新代码
   - 构建新版本
   - 部署到服务器

3. **硬件升级**
   - 推送新固件到设备
   - 设备自动更新固件

4. **AI 模型升级**
   - 上传新模型
   - 重启 AI 服务

### 8.2 维护
- **数据库备份**：定期备份数据库
  ```bash
  docker exec -t smallsteps-postgres pg_dump -U smallsteps smallsteps > backup.sql
  ```

- **日志清理**：定期清理日志文件
  ```bash
  sudo journalctl --vacuum-time=7d
  ```

- **系统更新**：定期更新系统和依赖包
  ```bash
  sudo apt update && sudo apt upgrade
  ```

## 9. 故障排查

### 9.1 常见问题

#### 9.1.1 后端服务无法启动
- **检查数据库连接**：确保 PostgreSQL 服务正常运行
- **检查环境变量**：确保环境变量配置正确
- **查看日志**：查看容器日志了解具体错误

#### 9.1.2 前端无法访问 API
- **检查 API 地址**：确保 API 地址配置正确
- **检查 CORS 配置**：确保后端配置了正确的 CORS 策略
- **检查网络连接**：确保前端和后端在同一网络

#### 9.1.3 设备无法连接
- **检查 Wi-Fi 配置**：确保 Wi-Fi 信息正确
- **检查 MQTT 配置**：确保 MQTT 服务器信息正确
- **检查设备状态**：确保设备电量充足

#### 9.1.4 AI 服务无响应
- **检查模型文件**：确保模型文件存在且完整
- **检查服务状态**：确保 AI 服务正常运行
- **查看日志**：查看容器日志了解具体错误

### 9.2 故障处理流程
1. **识别问题**：通过监控和日志识别问题
2. **定位原因**：分析问题原因
3. **实施修复**：采取相应的修复措施
4. **验证修复**：验证问题是否解决
5. **记录问题**：记录问题和解决方案

## 10. 安全措施

### 10.1 网络安全
- **使用 HTTPS**：配置 SSL 证书
- **防火墙**：配置防火墙规则，只开放必要的端口
- **VPN**：使用 VPN 连接内部网络

### 10.2 数据安全
- **数据库加密**：对敏感数据进行加密存储
- **备份策略**：定期备份数据，存储在安全的位置
- **访问控制**：限制数据库访问权限

### 10.3 应用安全
- **漏洞扫描**：定期进行漏洞扫描
- **依赖更新**：定期更新依赖包，修复安全漏洞
- **代码审查**：进行安全代码审查

## 11. 总结

本部署指南详细描述了 Small Steps 系统的部署流程，包括后端、前端、硬件和 AI 中台的部署步骤。通过按照本指南进行部署，可以确保系统能够正确、安全地运行在生产环境中。

部署过程中需要注意以下几点：
- 确保环境变量配置正确，特别是数据库连接信息和 JWT 密钥
- 定期备份数据库和重要数据
- 配置适当的监控和日志系统，及时发现和解决问题
- 采取必要的安全措施，保护系统和数据安全

总之，本部署指南为 Small Steps 系统的部署工作提供了明确的指导，确保系统的顺利部署和稳定运行，为 ADHD 儿童的行为习惯养成提供持续的技术支持。