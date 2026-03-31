# 小智 AI (Small Steps Demo) 项目运行与排线指南

本文档汇总了如何编译、烧录本项目固件，以及常见开发板的硬件排线定义。

## 1. 快速编译与烧录

本项目提供了一个 `scripts/release.py` 脚本，可以一键自动完成配置、编译和固件打包。

### 1.1 环境准备
请确保你已经安装了 [ESP-IDF 5.x](https://docs.espressif.com/projects/esp-idf/zh_CN/latest/esp32s3/get-started/index.html) 开发环境。

### 1.2 编译指定开发板
在项目根目录下，使用以下命令编译特定开发板的固件：

```bash
# 自动查找并编译指定开发板（推荐）
python scripts/release.py [开发板目录名]

# 示例：编译立创实战派 S3
python scripts/release.py lichuang-dev

# 示例：编译 ESP32-S3-BOX-3
python scripts/release.py esp-box-3

python scripts/release.py smallsteps-s3-v1
```

- 脚本会自动读取 `main/boards/[开发板目录名]/config.json` 获取配置。
- 编译完成后，固件会生成在 `releases/` 目录下，格式为 `v[版本号]_[开发板名].zip`。
- 同时 `build/merged-binary.bin` 也会更新为最新编译的固件。

### 1.3 烧录固件
连接开发板到电脑，确认串口号（如 `COM3` 或 `/dev/ttyUSB0`），然后运行：

```bash
python scripts/release.py smallsteps-s3-v1

直接使用命令行烧录： 该项目提供了标准的烧录脚本，建议您尝试直接在终端运行以下命令，绕过可能出错的工具：
powershell
# 确保您在 demo/xiaozhi-esp32 目录下
cd demo/xiaozhi-esp32
# 直接调用标准 IDF 命令 (编译 + 烧录 + 监控)
idf.py -p COM5 build flash monitor

# 如果需要关闭正在运行的idf.py，可以使用以下命令：
taskkill /F /IM python.exe

idf.py -p COM5 flash monitor
或者使用项目提供的脚本：
python scripts/release.py [您的开发板型号]
```

如果遇到权限问题或无法识别，请按住 `BOOT (0)` 键再按一下 `RST` 键进入下载模式。

---

## 2. 硬件排线参考 (Pinout)

以下是几种常见支持开发板的引脚定义，详细定义请参考 `main/boards/[开发板名]/config.h`。

### 2.1 立创·实战派 ESP32-S3 (lichuang-dev)

| 功能模块 | 信号 | 引脚 (GPIO) | 备注 |
| :--- | :--- | :--- | :--- |
| **I2S 音频** | MCLK | 38 | 主时钟 |
| | BCLK | 14 | 位时钟 |
| | WS (LRCK) | 13 | 字选择 |
| | DIN (MIC) | 12 | 麦克风输入 |
| | DOUT (SPK) | 45 | 扬声器输出 |
| **I2C 音频控制** | SDA | 1 | Codec 控制数据 |
| | SCL | 2 | Codec 控制时钟 |
| | Codec | ES8311 | 地址: 0x18 |
| **显示屏 (ST7789)** | SCLK | - | 硬件 SPI |
| | MOSI | - | 硬件 SPI |
| | BL (背光) | 42 | 高电平有效 |
| **其他** | LED | 48 | 内置 WS2812 |
| | BOOT | 0 | 下载/功能键 |

### 2.2 乐鑫 ESP32-S3-BOX-3 (esp-box-3)

| 功能模块 | 信号 | 引脚 (GPIO) | 备注 |
| :--- | :--- | :--- | :--- |
| **I2S 音频** | MCLK | 2 | |
| | BCLK | 17 | |
| | WS | 45 | |
| | DIN | 16 | |
| | DOUT | 15 | |
| **I2C 音频控制** | SDA | 8 | |
| | SCL | 18 | |
| | PA Enable | 46 | 功放使能 |
| **显示屏** | BL (背光) | 47 | |

### 2.3 面包板/简易版 (bread-compact-wifi)

适用于自制面包板搭建，支持 SSD1306/SH1106 OLED 屏幕。

| 功能模块 | 信号 | 引脚 (GPIO) | 备注 |
| :--- | :--- | :--- | :--- |
| **I2S 麦克风** | WS | 4 | INMP441 等 |
| | SCK | 5 | |
| | SD (DIN) | 6 | |
| **I2S 扬声器** | DOUT | 7 | MAX98357A 等 |
| | BCLK | 15 | (Simplex 模式使用 GPIO 7/15/16) |
| | LRCK | 16 | |
| **OLED 显示屏** | SDA | 41 | I2C 数据 |
| | SCL | 42 | I2C 时钟 |
| **按键** | BOOT | 0 | 唤醒/中断 |
| | Touch | 47 | 触摸按键 |
| | Vol Up | 40 | 音量+ |
| | Vol Down | 39 | 音量- |
| **其他** | LED | 48 | 状态指示灯 |

### 2.4 微雪 1.8寸 AMOLED (esp32-s3-touch-amoled-1.8)

| 功能模块 | 信号 | 引脚 (GPIO) | 备注 |
| :--- | :--- | :--- | :--- |
| **I2S 音频** | MCLK | 16 | |
| | BCLK | 9 | |
| | WS | 45 | |
| | DIN | 10 | |
| | DOUT | 8 | |
| **I2C 音频控制** | SDA | 15 | ES8311 |
| | SCL | 14 | |
| **OLED (QSPI)** | CS | 12 | |
| | PCLK | 11 | |
| | DATA 0-3 | 4, 5, 6, 7 | QSPI 数据线 |

## 3. 查看更多开发板配置

所有支持的开发板配置均位于 `main/boards/` 目录下。如果你使用其他开发板，请直接查看对应目录下的 `config.h` 文件获取最准确的引脚定义。

常见的开发板目录名参考：
- `m5stack-core-s3`: M5Stack CoreS3
- `xingzhi-cube-*`: 行智 AI 魔方系列
- `magiclick-*`: MagicClick 系列
- `sensecap-watcher`: Seeed Studio Watcher
