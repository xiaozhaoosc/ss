# SmallSteps S3 V1 - 版本 2.1.0 发布说明 (蓝牙音频增强版)

**发布日期**: 2026-03-21  
**基础固件**: xiaozhi-esp32 v2.2.0  
**板型**: smallsteps-s3-v1  
**状态**: ✅ Phase 1 & 2 已全线通过验证

---

## 📋 版本概述

本次版本 (v2.1.0) 在 v2.0.1 稳定硬件驱动的基础上，实现了**蓝牙音频 A2DP Source 模式的深度增强**。现在，“小步”终端支持智能搜寻、RSSI 过滤自动连接以及完善的手动列表选择逻辑。同时，引入了**自动化工程归档规范**，确保了项目的长期维护与记忆连续性。

---

## ✨ 核心功能 (Phase 2 新增)

### 1. 智能蓝牙音频集成 (A2DP Source)
- ✅ **自动搜寻连接** - 长按 OK 键启动，自动选取并连接信号最强的二级。
- ✅ **毫秒级响应** - 搜寻完成即刻触发连接，无需人工等待。
- ✅ **手动选择 UI** - 若自动连接未命中，1.8 寸屏将展示设备列表，支持 Up/Down 键循环滚动与 OK 键确认。
- ✅ **双向同步映射** - 连接状态实时同步至 UI 通知与音效系统。

### 2. 自动化工程管理
- ✅ **归档准则沉淀** - 内化 `.agent/rules/doc-archival-policy.md`，执行“年月日”级版本化归档。
- ✅ **上下文自对齐** - 通过 `.agent/context.md` 路线图实时追踪任务状态，支持跨会话记忆恢复。

### 已验证基础功能 (Phase 1)
- ✅ **1.8寸屏显示** (ST7735)
- ✅ **MAX98357A 播放**
- ✅ **INMP441 录音** (LEFT 声道适配)
- ✅ **语音唤醒** ("肉肉同学", 阈值 10)

---

## 🔧 打包与构建修复 (v2.1.0 重大更新)

### 修复: release.py 打包失败 ✅ 已解决

#### 现象
执行 `python scripts/release.py smallsteps-s3-v1` 时报错：
`[ERROR] main/CMakeLists.txt 中未找到 board_type smallsteps-s3-v1`

#### 根本原因
由于 `release.py` 脚本使用正则表达式搜索 `CMakeLists.txt` 中的 `set(BOARD_TYPE "...")` 模式，而 `smallsteps-s3-v1` 的配置项未在 CMake 和 Kconfig 中正式注册，导致脚本解析失败且编译链条不闭环。

#### 解决方案
1. **Kconfig 注册**: 在 `main/Kconfig.projbuild` 中添加 `BOARD_TYPE_SMALLSTEPS_S3_V1` 选项。
2. **CMake 映射**: 在 `main/CMakeLists.txt` 中补充板型到目录的映射逻辑，并配置默认字体 (`puhui_basic_16_4`)。
3. **组件依赖**: 在 `main/CMakeLists.txt` 的 `idf_component_register` 中显式添加 `PRIV_REQUIRES bt`，解决蓝牙 API 头文件引用问题。
4. **功能开启**: 在板型 `config.json` 中完整配置 `BT_ENABLED`、`CLASSIC_ENABLED` 与 `A2DP_ENABLE`。
5. **脚本适配**: 确保 `BOARD_TYPE` 宏在编译阶段正确注入。

---

## 🚀 编译、烧录与打包

### 打包 (Package)
```bash
# 生成 v2.1.0 版本的归档压缩包
python scripts/release.py smallsteps-s3-v1
```

### 编译与烧录 (Build & Flash)
```bash
# 进入构建目录
idf.py build
idf.py -p COM[X] flash monitor
```

---

## 🧪 测试验证清单

- ✅ **蓝牙自动搜寻流程** (3s 长按 -> 自动闪连)
- ✅ **手动设备切换** (UI 滚动 -> 选取连接)
- ✅ **文档自动化归档流** (生成的 Plan/Walkthrough 自动转入 archive/)
- ✅ **全系统回归测试** (各按键、唤醒、音频功能正常)

---

## 📄 版本历史

### v2.1.0 (2026-03-21) - 当前版本
- ✅ 升级蓝牙逻辑支持 A2DP Source 自动/手动双模
- ✅ 集成自动化工程管理与 RoadMap 系统
- ✅ 修复 `release.py` 打包脚本的板型搜索报错
- ✅ 优化 1.8 寸屏列表显示 UI

### v2.0.1 (2026-02-12)
- ✅ 修复白屏/麦克风无声等基础驱动问题

---

**维护者**: SmallSteps 首席工程师  
**最后更新**: 2026-03-21 23:53  
**板型**: smallsteps-s3-v1 (S3-N16R8)
:
  - SCK: GPIO 41
  - WS: GPIO 42
  - SD: GPIO 2
  - **L/R: VDD** (输出 LEFT 声道)

> [!NOTE]
> **硬件状态**: 经核实,当前硬件的 INMP441 L/R 引脚已可靠接入 VDD,软件已同步配置为 `I2S_STD_SLOT_LEFT`。

**扬声器 (MAX98357A)**
- **接口**: I2S (Simplex TX)
- **引脚配置**:
  - BCLK: GPIO 8
  - LRC: GPIO 21
  - DIN: GPIO 16

#### 显示屏
- **型号**: ST7735 (128x160)
- **接口**: SPI (FSPI)
- **驱动**: esp_lcd_new_panel_st7789 (兼容模式)

#### 按键
- **BOOT**: GPIO 0
- **UP**: GPIO 4
- **DOWN**: GPIO 5
- **OK**: GPIO 6
- **BACK**: GPIO 7

#### 其他外设
- **RGB 灯环 (WS2812B)**: GPIO 15
- **震动马达**: GPIO 1

### 软件配置

#### 唤醒词配置
- **唤醒词**: "肉肉同学" (rou rou tong xue)
- **识别模型**: Multinet7 中文通用识别
- **灵敏度**: 10 (优化后,原为 20)

#### 编译配置
```json
{
    "target": "esp32s3",
    "builds": [{
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
            "CONFIG_CUSTOM_WAKE_WORD_THRESHOLD=10"
        ]
    }]
}
```

---

## 🚀 编译与烧录

### 编译命令
```bash
# 方法 1: 使用 release.py
python scripts/release.py smallsteps-s3-v1

# 方法 2: 使用 idf.py
idf.py build
```

### 烧录命令
```bash
idf.py -p COM5 flash monitor
```

---

## 🧪 测试验证

### 功能测试清单
- ✅ **屏幕显示测试**
- ✅ **音频测试**
- ✅ **语音唤醒测试**
- ✅ **网络测试**
- ✅ **按键测试**

---

## 📄 版本历史

### v2.0.1 (2026-02-12) - 当前版本
- ✅ 修复白屏问题
- ✅ 修复麦克风无声问题
- ✅ 修复语音唤醒失败问题
- ✅ 优化唤醒灵敏度
- ✅ 完成核心功能验证

---

**维护者**: SmallSteps 项目团队  
**最后更新**: 2026-02-12 15:54  
**固件版本**: 基于 xiaozhi-esp32 v2.1.0
