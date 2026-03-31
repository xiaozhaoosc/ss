# SmallSteps S3 V1 开发板配置文档

## 📋 硬件规格

### 主控芯片
- **MCU**: ESP32-S3-WROOM-1-N16R8
- **Flash**: 16MB
- **PSRAM**: 8MB (Octal)

### 显示屏
- **型号**: ST7735 (128x160)
- **接口**: SPI (FSPI)
- **引脚配置**:
  - SCK: GPIO 12
  - MOSI: GPIO 11
  - CS: GPIO 10
  - DC: GPIO 9
  - RST: GPIO 46
  - BLK: GPIO 3

### 音频系统

#### 麦克风 (INMP441)
- **接口**: I2S (Simplex RX)
- **引脚配置**:
  - SCK: GPIO 41
  - WS: GPIO 42
  - SD: GPIO 2
  - L/R: VDD (输出 LEFT 声道)

> [!WARNING]
> **硬件注意事项**: 当前硬件版本的 INMP441 的 L/R 引脚为悬空状态,因此麦克风输出 **LEFT 声道**数据。代码已配置为读取 LEFT 声道。如果后续硬件将 L/R 接地,需要修改代码为 `I2S_STD_SLOT_RIGHT`。

#### 扬声器 (MAX98357A)
- **接口**: I2S (Simplex TX)
- **引脚配置**:
  - BCLK: GPIO 8
  - LRC: GPIO 21
  - DIN: GPIO 16

### 按键
- **BOOT**: GPIO 0 (开发板自带)
- **UP**: GPIO 4
- **DOWN**: GPIO 5
- **OK**: GPIO 6
- **BACK**: GPIO 7

### 其他外设
- **RGB 灯环 (WS2812B)**: GPIO 15
- **震动马达**: GPIO 1

---

## 🔧 软件配置

### 编译命令
```bash
# 使用 ESP-IDF 5.5.2 PowerShell/CMD
cd d:\kenzhao\cust_projects\smallsteps\demo\xiaozhi-esp32
python scripts/release.py smallsteps-s3-v1
```

### 烧录命令
```bash
idf.py -p COM5 flash monitor
```

### 唤醒词配置
- **唤醒词**: "肉肉同学" (rou rou tong xue)
- **识别模型**: Multinet7 中文通用识别
- **灵敏度**: 20 (可调范围 1-99,数值越小越灵敏)

---

## 🐛 已知问题与解决方案

### 1. 白屏问题 ✅ 已解决
**原因**: 构建系统未正确识别板型,使用了错误的显示驱动。

**解决方案**:
- 在 `main/Kconfig.projbuild` 添加 `BOARD_TYPE_SMALLSTEPS_S3_V1` 选项
- 调整 `main/CMakeLists.txt` 中板型判断逻辑位置
- 使用 `esp_lcd_new_panel_st7789` 驱动(兼容 ST7735)

### 2. 麦克风无声 ✅ 已解决
**根本原因**: INMP441 的 L/R 引脚为**悬空状态**,导致麦克风输出 LEFT 声道数据,但代码默认读取 RIGHT 声道。

**诊断过程**:
1. 添加调试日志发现所有采样值为 0 (`max=0, min=0, avg=0`)
2. 尝试切换声道配置为 LEFT
3. 验证成功,麦克风立即有数据 (`max=19598, avg=715-6769`)

**解决方案**:
在 `smallsteps_s3_v1.cc` 中使用 `NoAudioCodecSimplex` 的重载构造函数,显式指定麦克风使用 **LEFT 声道**:
```cpp
static NoAudioCodecSimplex audio_codec(
    AUDIO_INPUT_SAMPLE_RATE, AUDIO_OUTPUT_SAMPLE_RATE,
    AUDIO_I2S_SPK_GPIO_BCLK, AUDIO_I2S_SPK_GPIO_LRCK, AUDIO_I2S_SPK_GPIO_DOUT, 
    I2S_STD_SLOT_LEFT,  // 扬声器使用 LEFT 声道
    AUDIO_I2S_MIC_GPIO_SCK, AUDIO_I2S_MIC_GPIO_WS, AUDIO_I2S_MIC_GPIO_DIN,
    I2S_STD_SLOT_LEFT   // 麦克风使用 LEFT 声道 (L/R 悬空)
);
```

**硬件修复建议** (可选):
如果希望符合标准设计,可以将 INMP441 的 L/R 引脚焊接到 GND,然后修改代码为 `I2S_STD_SLOT_RIGHT`。

### 3. 编译编码错误 ✅ 已解决
**原因**: `release.py` 和 `config.json` 的编码问题。

**解决方案**:
- 修改 `scripts/release.py` 使用 UTF-8 编码读取 JSON
- 将中文字符转换为 Unicode 转义序列 (`\u8089\u8089\u540c\u5b66`)


---

## 📝 配置文件说明

### config.json
```json
{
    "target": "esp32s3",
    "builds": [
        {
            "name": "smallsteps-s3-v1",
            "sdkconfig_append": [
                "CONFIG_ESPTOOLPY_FLASHSIZE_16MB=y",
                "CONFIG_PARTITION_TABLE_CUSTOM_FILENAME=\"partitions/v2/16m.csv\"",
                "CONFIG_BOARD_TYPE_SMALLSTEPS_S3_V1=y",
                "CONFIG_LCD_ST7735_128X160=y",
                "CONFIG_USE_CUSTOM_WAKE_WORD=y",
                "CONFIG_SR_MN_CN_MULTINET7_QUANT=y",
                "CONFIG_CUSTOM_WAKE_WORD=\"rou rou tong xue\"",
                "CONFIG_CUSTOM_WAKE_WORD_DISPLAY=\"\\u8089\\u8089\\u540c\\u5b66\"",
                "CONFIG_CUSTOM_WAKE_WORD_THRESHOLD=20"
            ]
        }
    ]
}
```

### 关键配置说明
- `CONFIG_BOARD_TYPE_SMALLSTEPS_S3_V1`: 板型标识
- `CONFIG_LCD_ST7735_128X160`: 显示屏型号
- `CONFIG_USE_CUSTOM_WAKE_WORD`: 启用自定义唤醒词
- `CONFIG_SR_MN_CN_MULTINET7_QUANT`: 中文语音识别模型
- `CONFIG_CUSTOM_WAKE_WORD`: 唤醒词拼音
- `CONFIG_CUSTOM_WAKE_WORD_DISPLAY`: 唤醒词显示文本（Unicode 编码）

---

## 🎯 功能特性

### 已验证功能
- ✅ 1.8寸 ST7735 屏幕显示
- ✅ MAX98357A 扬声器播放
- ✅ INMP441 麦克风录音 (LEFT 声道)
- ✅ 语音唤醒识别 (按键触发)
- ✅ WiFi 连接
- ✅ MQTT 通信
- ✅ 设备激活

### 待测试功能
- ⏳ 语音唤醒 (麦克风触发) - **需测试**
- ⏳ 语音对话
- ⏳ WS2812B 灯效
- ⏳ 震动反馈
- ⏳ 按键交互完整流程


---

## 🔍 调试技巧

### 查看日志
```bash
idf.py -p COM5 monitor
```

### 清理构建
```bash
Remove-Item -Recurse -Force build,sdkconfig,sdkconfig.old
```

### 修改唤醒词灵敏度
编辑 `config.json` 中的 `CONFIG_CUSTOM_WAKE_WORD_THRESHOLD` 值：
- 默认: 20
- 更灵敏: 10-15
- 更严格: 25-30

---

## 📚 参考资料

- [ESP-IDF 编程指南](https://docs.espressif.com/projects/esp-idf/zh_CN/latest/esp32s3/)
- [ESP-SR 语音识别](https://github.com/espressif/esp-sr)
- [INMP441 数据手册](https://invensense.tdk.com/products/digital/inmp441/)
- [MAX98357A 数据手册](https://www.analog.com/media/en/technical-documentation/data-sheets/MAX98357A-MAX98357B.pdf)

---

## 📧 技术支持

如遇问题，请提供以下信息：
1. 完整的编译日志
2. 串口监视器输出
3. 硬件接线照片
4. ESP-IDF 版本信息

---

**最后更新**: 2026-02-12  
**固件版本**: v2.0.1 (基于 xiaozhi-esp32 v2.1.0)  
**维护者**: SmallSteps 项目团队
