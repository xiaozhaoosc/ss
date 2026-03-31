# ESP32 SD 卡文件上传方案

由于 MicroPython 的内存限制，通过 Web 上传大文件（如 MP3）不太可行。推荐使用以下方法：

## 方案 1：FTP 上传（推荐）⭐

### 步骤

1. **在 ESP32 上运行 FTP 服务器**：
   ```python
   # 安装 uftpd 库（如果还没有）
   # 在 ESP32 REPL 中运行：
   import mip
   mip.install("github:cpopp/MicroFTPServer")
   
   # 启动 FTP 服务器
   from sd_manager import SDManager
   import config
   
   # 挂载 SD 卡
   sd = SDManager(config.SD_SCK_PIN, config.SD_MOSI_PIN, config.SD_MISO_PIN, config.SD_CS_PIN)
   sd.mount()
   sd.ensure_dfplayer_folders()
   
   # 启动 FTP
   from uftpd import FTPServer
   ftp = FTPServer()
   ftp.start()
   ```

2. **在电脑上使用 FTP 客户端**：
   - 下载 FileZilla 或 WinSCP
   - 连接到 ESP32 的 IP 地址
   - 上传 MP3 文件到 `/sd/01/` 文件夹

---

## 方案 2：ampy 直接上传

### 步骤

```bash
# 挂载 SD 卡后，使用 ampy 上传文件
ampy --port COM3 put your_audio.mp3 /sd/01/001.mp3
```

**限制：** 需要先在 ESP32 上挂载 SD 卡。

---

## 方案 3：直接用电脑格式化 SD 卡

### 步骤

1. **取出 SD 卡**
2. **插入电脑读卡器**
3. **格式化为 FAT32**
4. **创建文件夹并复制文件**：
   ```
   /01/001.mp3
   /01/002.mp3
   /02/001.mp3
   ```
5. **插回 DFPlayer**

**优点：** 最简单、最快速  
**缺点：** 需要频繁插拔 SD 卡

---

## 推荐工作流程

1. **首次设置**：用电脑格式化 SD 卡并上传初始音频文件
2. **后续更新**：使用 FTP 方案远程上传新文件
3. **调试测试**：使用 Web 服务器查看文件列表

---

## Web 服务器使用

虽然 Web 上传功能受限，但可以用来查看文件列表：

```python
# 启动 Web 服务器
from web_server import start_server
start_server()

# 浏览器访问：http://<ESP32_IP>
# 可以查看 SD 卡上的所有文件
```

---

## 文件命名规则提醒

- **文件夹**：01, 02, 03, ... 99（两位数字）
- **文件**：001.mp3, 002.mp3, ... 255.mp3（三位数字）
- **扩展名**：.mp3 或 .wav（小写）
