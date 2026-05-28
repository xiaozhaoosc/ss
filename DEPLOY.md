# Small Steps 部署指南

## 🚀 快速开始

### 安装快捷命令

```bash
# 确保 ~/bin 在 PATH 中
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### 使用快捷命令

```bash
# 部署全部（后端 + 管理后台 + H5移动端）
ss /ss-all

# 仅部署后端 API
ss /ss-api

# 仅部署管理后台
ss /ss-ui

# 仅部署 H5 移动端
ss /ss-app:h5

# 显示帮助
ss help
```

## 📋 命令说明

| 命令 | 说明 | 执行内容 |
|------|------|----------|
| `/ss-all` | 完整部署 | Maven打包 + 构建UI + 构建H5 + 上传 + Docker重启 |
| `/ss-api` | 部署后端 | Maven打包 + 上传JAR + Docker重启 |
| `/ss-ui` | 部署管理后台 | 构建UI + 上传dist + Docker重启 |
| `/ss-app:h5` | 部署移动端 | 构建H5 + 上传dist + Docker重启 |

## 🔧 优化特性

### 1. 压缩传输
- 所有文件上传前都会压缩（tar.gz）
- 传输完成后自动解压并删除压缩包
- 节省约 30-50% 传输时间

### 2. 静默构建
- Maven 和前端构建使用 `-q` 或重定向到 `/dev/null`
- 只显示关键信息，减少输出噪音

### 3. 自动清理
- 脚本退出时自动清理临时文件
- 使用 `trap` 确保异常退出也能清理

### 4. 错误处理
- 使用 `set -e` 遇到错误立即停止
- 彩色日志输出，便于区分信息类型

## 📊 部署流程

### 完整部署 (/ss-all)

```
1. 检查 SSH 连接
2. 创建远程目录
3. Maven 打包后端 (跳过测试)
4. 压缩并上传 JAR
5. 构建管理后台
6. 压缩并上传 UI
7. 构建 H5 移动端
8. 压缩并上传 H5
9. 停止旧容器
10. 启动新容器
11. 验证部署状态
```

### 部分部署

只执行对应模块的构建和上传，最后都会执行 Docker 重启。

## 🌐 服务地址

| 服务 | 地址 | 说明 |
|------|------|------|
| 管理后台 | http://10.8.0.1:80 | Vue3 + Element Plus |
| 移动端 H5 | http://10.8.0.1:81 | UniApp X |
| API 接口 | http://10.8.0.1:8080/ssapi | Spring Boot |

## 🔐 测试账号

| 端 | 用户名 | 密码 |
|----|--------|------|
| 管理后台 | admin | admin123 |
| 家长端 | parent_zhang | admin123 |
| 儿童端 | child_xiaoming | admin123 |

## 🛠️ 故障排除

### SSH 连接失败

```bash
# 测试 SSH 连接
ssh -p 2216 ken3zhao@10.8.0.1 "echo ok"

# 检查公钥
cat ~/.ssh/id_rsa.pub
```

### Maven 打包失败

```bash
# 清理并重新打包
cd /home/ken4zhao/Documents/office/jushuang1/github/ss/smallsteps-api
mvn clean package -DskipTests -U
```

### 前端构建失败

```bash
# 清理依赖
cd /home/ken4zhao/Documents/office/jushuang1/github/ss/smallsteps-ui
rm -rf node_modules package-lock.json
npm install
```

### Docker 启动失败

```bash
# SSH 登录服务器查看日志
ssh -p 2216 ken3zhao@10.8.0.1
cd /home/ken3zhao/smallsteps_rsync
docker-compose logs -f
```

## 📁 目录结构

### 本地项目

```
/home/ken4zhao/Documents/office/jushuang1/github/ss/
├── smallsteps-api/          # 后端 API
├── smallsteps-ui/           # 管理后台
├── smallsteps-app/          # 移动端
├── deploy.sh                # 部署脚本
└── docker-compose.yml       # Docker 配置
```

### 服务器部署

```
/home/ken3zhao/smallsteps_rsync/
├── smallsteps-api/
│   └── smallsteps-admin.jar
├── smallsteps-ui/
│   ├── dist/                # H5 移动端
│   └── dist/webadminss/     # 管理后台
└── docker-compose.yml
```

## ⚡ 性能优化

### 传输优化

- **压缩传输**: tar.gz 压缩后传输，减少 30-50% 传输量
- **增量更新**: 只传输变更文件（rsync）
- **并行传输**: 可配置并行传输多个文件

### 构建优化

- **跳过测试**: Maven 使用 `-DskipTests`
- **静默模式**: 减少输出，提高速度
- **缓存利用**: npm 和 Maven 缓存

## 📝 更新日志

### v1.0.0 (2026-05-28)

- ✅ 初始版本
- ✅ 支持完整部署和部分部署
- ✅ 压缩传输优化
- ✅ 快捷命令支持
- ✅ 彩色日志输出

---

*文档维护: Small Steps DevOps*
