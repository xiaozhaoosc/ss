# Network Configuration
# ⚠️ Security Warning: Do not commit real passwords to public repositories!

WIFI_SSID = "ChinaNet-TzdG"
WIFI_PASS = "zzakxw3v"

# BLE Name (Max 9 chars recommended for advertising packet limit)
BLE_NAME = "SmallStep"

# DFPlayer Mini Configuration
DFPLAYER_UART_ID = 2        # UART2
DFPLAYER_TX_PIN = 17        # ESP32 TX -> DFPlayer RX
DFPLAYER_RX_PIN = 18        # ESP32 RX <- DFPlayer TX

# SD Card Configuration (SPI)
SD_MISO_PIN = 13            # SPI MISO
SD_MOSI_PIN = 11            # SPI MOSI (shared with screen)
SD_SCK_PIN = 12             # SPI SCK (shared with screen)
SD_CS_PIN = 14              # SPI CS (unique for SD card)


