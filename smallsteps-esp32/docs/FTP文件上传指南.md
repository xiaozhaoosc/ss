# FTP 文件上传完整指南

## 🎯 目标
通过 FTP 将音频文件上传到 ESP32 的 SD 卡，供 DFPlayer 播放。

---

## 📋 准备工作

### 硬件连接
```
SD 卡模块接线：
  VCC  → ESP32 3.3V（⚠️ 必须 3.3V，不能 5V）
  GND  → GND
  MISO → GPIO 13
  MOSI → GPIO 11
  SCK  → GPIO 12
  CS   → GPIO 14
```

### SD 卡要求
- **格式**：FAT32
- **容量**：≤32GB
- **状态**：已插入 SD 卡模块

---

## 🚀 步骤 1：安装 FTP 服务器库

### 方法 A：使用 mip 安装（推荐）

在 ESP32 REPL 中运行：

```python
import mip
mip.install("github:cpopp/MicroFTPServer")
```

### 方法 B：手动安装

1. 下载 `uftpd.py` 文件
2. 使用 ampy 上传到 ESP32：
   ```bash
   ampy --port COM3 put uftpd.py /lib/uftpd.py
   ```

---

## 🚀 步骤 2：启动 FTP 服务器

在 ESP32 REPL 中运行：

```python
import start_ftp
```

**预期输出：**
```
=== Starting FTP Server ===

[1] Connecting to WiFi...
WiFi connected!
IP Address: 192.168.1.100

[2] Mounting SD card...
SD card mounted at /sd

[3] Creating DFPlayer folders...
DFPlayer folders ready (01-10)

[4] Starting FTP server...

==================================================
FTP Server Ready!
==================================================
Host: 192.168.1.100
Port: 21
User: micro
Pass: python
Root: /sd
==================================================
```

**记下 IP 地址**（如 `192.168.1.100`），后面会用到。

---

## 🚀 步骤 3：使用 FTP 客户端连接

### 方法 A：FileZilla（推荐，图形界面）

1. **下载 FileZilla**：https://filezilla-project.org/

2. **连接设置**：
   - 主机：`ftp://192.168.1.100`（替换为你的 IP）
   - 用户名：`micro`
   - 密码：`python`
   - 端口：`21`

3. **点击"快速连接"**

4. **导航到 `/sd/01/` 文件夹**

5. **拖拽 MP3 文件上传**

---

### 方法 B：WinSCP（Windows）

1. **下载 WinSCP**：https://winscp.net/

2. **新建站点**：
   - 文件协议：`FTP`
   - 主机名：`192.168.1.100`
   - 端口号：`21`
   - 用户名：`micro`
   - 密码：`python`

3. **登录并上传文件**

---

### 方法 C：命令行（Linux/Mac）

```bash
ftp 192.168.1.100
# 输入用户名：micro
# 输入密码：python

cd /sd/01
put 001.mp3
put 002.mp3
quit
```

---

## 📁 文件命名规则

### 文件夹结构
```
/sd/
├── 01/              ← 文件夹编号（01-99）
│   ├── 001.mp3      ← 文件编号（001-255）
│   ├── 002.mp3
│   └── 003.mp3
├── 02/
│   ├── 001.mp3
│   └── 002.mp3
└── 03/
    └── 001.mp3
```

### 命名要求
- **文件夹**：两位数字（01, 02, ... 99）
- **文件**：三位数字 + 扩展名（001.mp3, 002.mp3, ... 255.mp3）
- **扩展名**：小写（.mp3 或 .wav）

---

## ✅ 步骤 4：验证上传

### 在 ESP32 REPL 中检查文件

```python
from sd_manager import SDManager
import config

sd = SDManager(config.SD_SCK_PIN, config.SD_MOSI_PIN, config.SD_MISO_PIN, config.SD_CS_PIN)
sd.mount()

# 列出 01 文件夹内容
files = sd.list_files("/01")
for f in files:
    size = sd.get_file_size("/01/" + f)
    print(f + " - " + str(size) + " bytes")
```

---

## 🎵 步骤 5：测试 DFPlayer 播放

```python
import test_dfplayer
```

如果一切正常，应该能听到音频播放！

---

## 🔧 故障排查

### 问题 1：无法连接 FTP
**检查：**
- ESP32 和电脑在同一 WiFi 网络
- IP 地址正确
- FTP 服务器已启动

---

### 问题 2：SD 卡挂载失败
**检查：**
- SD 卡已插入
- SD 卡格式为 FAT32
- 接线正确（特别是 VCC 必须 3.3V）

---

### 问题 3：上传后 DFPlayer 无法播放
**检查：**
- 文件命名正确（001.mp3, 002.mp3）
- 文件在正确的文件夹（/01/, /02/）
- 音频格式正确（MP3 或 WAV）
- 码率不要太高（推荐 128kbps）

---

## 💡 提示

1. **首次上传**：建议先上传 1-2 个小文件测试
2. **大文件上传**：可能需要几分钟，请耐心等待
3. **断开连接**：上传完成后记得断开 FTP 连接
4. **重启服务**：如果 FTP 卡住，重启 ESP32 即可

---

## 🎯 快速命令参考

```python
# 启动 FTP 服务器
import start_ftp

# 检查 SD 卡文件
from sd_manager import SDManager
import config
sd = SDManager(config.SD_SCK_PIN, config.SD_MOSI_PIN, config.SD_MISO_PIN, config.SD_CS_PIN)
sd.mount()
sd.list_files("/01")

# 测试播放
import test_dfplayer
```
