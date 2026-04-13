# ESP32-S3 Hardware Configuration

本文档记录 "Small Steps" 硬件终端的引脚定义与外设连接方式。

## 1. 核心控制器 (MCU)
- **Model**: ESP32-S3-WROOM-1
- **Flash**: 16MB
- **PSRAM**: 8MB

## 2. GPIO 引脚映射 (Pinout)

| 功能模块 | 引脚名称 | GPIO 引脚 | 备注 |
| :--- | :--- | :--- | :--- |
| **显示 (ST7735)** | LCD_SCLK | 12 | SPI 2 |
| | LCD_MOSI | 11 | SPI 2 |
| | LCD_CS | 10 | |
| | LCD_DC | 9 | 数据/命令切换 |
| | LCD_RST | 46 | 复位 |
| | LCD_BLK | 3 | 背光控制 (Active High) |
| **交互按键** | BTN_UP | 4 | Pull-up |
| | BTN_DOWN | 5 | Pull-up |
| | BTN_OK | 6 | Pull-up |
| | BTN_BACK | 7 | Pull-up |
| **指示灯 (WS2812B)** | RGB_DATA | 21 | 12-LED Ring |
| **音频 (DFPlayer)** | DF_TX | 18 | Connect to DF RX |
| | DF_RX | 17 | Connect to DF TX |
| **麦克风 (I2S)** | MIC_SCK | 41 | |
| | MIC_WS | 42 | |
| | MIC_SD | 2 | |
| **震动马达** | MOTOR | 14 | Haptic Feedback |

## 3. 外设协议规范

### 显示输出 (ST7735)
- **分辨率**: 128x160 (1.8")
- **驱动模式**: SPI Hard (20MHz)
- **颜色空间**: RGB565

### 音频系统
- **离线音频**: 通过 UART 控制 DFPlayer Mini，加载存储在 SD 卡中的 MP3 语音包。
- **在线采样**: 16kHz MONO I2S 输入，用于后期语音识别或树洞功能。

### 交互反馈
- **灯语**: 12 颗 WS2812B 构成的灯环。
- **触感**: 通过 GPIO14 驱动的小型线性震动马达。

---
> [!CAUTION]
> 修改引脚定义前必须同步更新 `smallsteps-esp32/device.py` 中的 `HardwareConfig` 类，否则会导致外设失效或硬件损坏。
