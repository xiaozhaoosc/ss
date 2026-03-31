# 安全清理实施计划

## 目标
- [x] **第一阶段: 密码脱敏**
    - [x] `docs\dockers\.env`
    - [x] `smallsteps-api\dockers\.env`
    - [x] `xiaozhi\xiaozhi-esp32-server-java\docker-compose.yml`
    - [x] `xiaozhi\xiaozhi-esp32-server-java\src\main\resources\application-dev.yml`
    - [x] `xiaozhi\xiaozhi-esp32-server-java\src\main\resources\application-prod.yml`
    - [x] `xiaozhi\xiaozhi-esp32-server-java\Dockerfile-mysql`
- [x] **第二阶段: 密钥移除**
    - [x] `smallsteps-ui\.env.production` (移除 RSA 私钥)
    - [x] `smallsteps-ui\.env.development` (移除 RSA 私钥)
- [x] **第三阶段: 网络加固**
    - [x] `docs\dockers\docker-compose.yml` (收紧基础设施端口映射)
- [x] **验证与推送**
    - [x] 验证脱敏结果
    - [x] Git 提交并推送

## 备注
- 统一使用假密码: `ui123456789~`
