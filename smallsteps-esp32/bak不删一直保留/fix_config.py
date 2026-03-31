# 快速修复：直接在 REPL 中定义配置
# 如果 config.py 没有更新，可以临时使用这个

# 在 ESP32 REPL 中运行以下代码：

# 方法 1：临时定义配置（快速测试）
import config
config.DFPLAYER_UART_ID = 2
config.DFPLAYER_TX_PIN = 17
config.DFPLAYER_RX_PIN = 18

# 然后运行测试
import test_dfplayer

# ==========================================
# 方法 2：永久修复（推荐）
# ==========================================
# 使用 ampy 重新上传 config.py：
# ampy --port COM3 put config.py

# 或者在 REPL 中手动创建：
"""
f = open('config.py', 'w')
f.write('''# Network Configuration
WIFI_SSID = "ChinaNet-TzdG"
WIFI_PASS = "zzakxw3v"

# BLE Name
BLE_NAME = "SmallStep"

# DFPlayer Mini Configuration
DFPLAYER_UART_ID = 2
DFPLAYER_TX_PIN = 17
DFPLAYER_RX_PIN = 18

# SD Card Configuration (SPI)
SD_MISO_PIN = 13
SD_MOSI_PIN = 11
SD_SCK_PIN = 12
SD_CS_PIN = 14
''')
f.close()
"""

# 然后重启 ESP32 或重新导入：
# import sys
# del sys.modules['config']
# import config
