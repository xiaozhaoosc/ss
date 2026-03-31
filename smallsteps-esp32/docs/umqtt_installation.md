# 修复 umqtt 库缺失问题

## 问题描述

运行 `main.py` 时出现错误：
```
ImportError: no module named 'umqtt'
```

这是因为 ESP32 上缺少 MicroPython 的 MQTT 库。

## 解决方案

已创建简化版的 `umqtt.simple` 库，包含以下文件：

### 文件列表

```
umqtt/
├── __init__.py          # 包初始化文件
└── simple.py            # MQTT 客户端实现
```

### 上传到 ESP32

需要将整个 `umqtt` 目录上传到 ESP32 的根目录：

**方法 1: 使用 Thonny**
1. 打开 Thonny IDE
2. 连接到 ESP32
3. 右键点击 `umqtt` 文件夹
4. 选择 "Upload to /"

**方法 2: 使用 ampy**
```bash
# 上传整个目录
ampy --port COM3 put umqtt
```

**方法 3: 使用 rshell**
```bash
rshell --port COM3
> cp -r umqtt /pyboard/
```

### 验证安装

在 ESP32 的 REPL 中运行：

```python
>>> from umqtt.simple import MQTTClient
>>> print("MQTT 库安装成功")
```

如果没有报错，说明安装成功。

## 库功能

`umqtt.simple` 提供了基本的 MQTT 功能：

- ✅ 连接/断开连接
- ✅ 发布消息（QoS 0, 1）
- ✅ 订阅主题
- ✅ 接收消息（回调）
- ✅ 心跳保持

## 使用示例

```python
from umqtt.simple import MQTTClient

# 创建客户端
client = MQTTClient(
    client_id="esp32_001",
    server="mqtt.smallsteps.com",
    port=1883,
    user="username",
    password="password"
)

# 连接
client.connect()

# 发布消息
client.publish("test/topic", "Hello MQTT")

# 订阅主题
def on_message(topic, msg):
    print(f"收到消息: {topic} -> {msg}")

client.set_callback(on_message)
client.subscribe("test/topic")

# 检查消息
while True:
    client.check_msg()
    time.sleep(0.1)
```

## 注意事项

1. **QoS 2 不支持**: 当前实现只支持 QoS 0 和 QoS 1
2. **SSL/TLS 不支持**: 如需加密连接，需要额外实现
3. **内存限制**: 大消息可能导致内存不足

## 故障排查

### 问题 1: 仍然提示 "no module named 'umqtt'"

**解决方法**:
- 确认 `umqtt` 目录已上传到 ESP32 根目录
- 在 REPL 中运行 `import os; os.listdir()` 检查是否有 `umqtt` 目录

### 问题 2: 连接失败

**解决方法**:
- 检查 WiFi 是否已连接
- 检查 MQTT 服务器地址和端口是否正确
- 检查防火墙设置

### 问题 3: 内存不足

**解决方法**:
- 减少消息大小
- 增加 `gc.collect()` 调用频率
- 使用 QoS 0 而非 QoS 1

## 完整安装步骤

1. **确保文件存在**
   ```bash
   ls umqtt/
   # 应该看到: __init__.py  simple.py
   ```

2. **上传到 ESP32**
   ```bash
   ampy --port COM3 put umqtt
   ```

3. **验证安装**
   ```python
   # 在 ESP32 REPL 中
   >>> from umqtt.simple import MQTTClient
   >>> print("OK")
   ```

4. **运行 main.py**
   ```python
   >>> exec(open('main.py').read())
   ```

## 相关文件

- [`umqtt/__init__.py`](file:///d:/kenzhao/cust_projects/smallsteps/projects/smallsteps-esp32/umqtt/__init__.py)
- [`umqtt/simple.py`](file:///d:/kenzhao/cust_projects/smallsteps/projects/smallsteps-esp32/umqtt/simple.py)
- [`mqtt_client.py`](file:///d:/kenzhao/cust_projects/smallsteps/projects/smallsteps-esp32/mqtt_client.py)
- [`main.py`](file:///d:/kenzhao/cust_projects/smallsteps/projects/smallsteps-esp32/main.py)
