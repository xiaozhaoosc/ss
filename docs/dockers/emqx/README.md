# EMQX 配置说明

## 问题
EMQX 5.x 默认启用认证，但没有预配置用户，导致 ESP32 连接失败。

## 解决方案

### 方案 A：在 Dashboard 中配置认证（推荐）

1. **访问 Dashboard**: http://192.168.1.21:18083
2. **登录**:
   - 用户名: `admin`
   - 密码: `public`

3. **创建认证器**:
   - 访问控制 → 认证 → 创建
   - 选择 "Built-in Database"
   - 点击创建

4. **添加用户**:
   - 在认证器中点击 "用户管理"
   - 添加用户:
     - 用户名: `admin`
     - 密码: `public`

### 方案 B：允许匿名访问（仅开发环境）

创建 `emqx.conf` 配置文件，允许匿名连接：

```conf
# 允许匿名访问
listeners.tcp.default {
  bind = "0.0.0.0:1883"
  max_connections = 1024000
}

# 禁用默认认证
authentication = []
```

然后在 `docker-compose.yml` 中挂载配置：

```yaml
emqx:
  volumes:
    - emqx_data:/opt/emqx/data
    - ./emqx/emqx.conf:/opt/emqx/etc/emqx.conf  # 添加这行
```

### 方案 C：使用环境变量（最简单）

在 `docker-compose.yml` 中添加环境变量：

```yaml
emqx:
  environment:
    EMQX_DASHBOARD__DEFAULT_USERNAME: ${EMQX_USER}
    EMQX_DASHBOARD__DEFAULT_PASSWORD: ${EMQX_PASSWORD}
    # 允许匿名访问
    EMQX_ALLOW_ANONYMOUS: "true"
```

## 验证连接

使用 mosquitto 客户端测试：

```bash
# 测试匿名连接
mosquitto_pub -h 192.168.1.21 -p 1883 -t test -m "hello"

# 测试认证连接
mosquitto_pub -h 192.168.1.21 -p 1883 -u admin -P public -t test -m "hello"
```

## 当前配置

根据 `.env` 文件：
- EMQX_USER=admin
- EMQX_PASSWORD=public

ESP32 配置应该是：
- MQTT_BROKER=192.168.1.21
- MQTT_USER=admin
- MQTT_PASS=public
