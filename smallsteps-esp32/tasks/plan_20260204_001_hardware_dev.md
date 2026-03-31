# 硬件开发详细计划 (Hardware Development Plan)
> **ID**: plan_20260204_001_hardware_dev
> **Target**: ESP32-S3 + ST7735 (1.8") + WS2812B
> **Firmware**: MicroPython

## 1. 现状回顾 (Status Quo)
基于 `device.py` 和 `test_hw.py` 的分析，基础驱动层 (Phase 1) 已有高完成度：
- **Display**: ST7735 SPI 驱动已调通 (128x160 RGB565).
- **Control**: 4按键 (Up/Down/OK/Back) 驱动已就绪。
- **Feedback**: WS2812B 灯环、音频 (DFPlayer)、震动马达驱动均已验证。
- **Conn**: WiFi, BLE 基础连接代码已存在。

## 2. Phase 2: UI/UX System (The Anchor) - [重点]
核心目标：构建一套“低认知负荷”的交互系统。

### 2.1 基础 UI 框架 (UI Framework)
- **Design System**:
    - **Palette**: 黑底 (0x0000) 为主，高对比度前景色 (Cyan, Yellow, Green)。
    - **Font**: 默认 8x8 或更大字号，避免密集排版。
    - **Navigation**:
        - 状态栏 (Top 20px): WiFi, Time, Battery (模拟)。
        - 导航栏 (Bottom 20px): 当前可用按键提示 (如 "OK: Start").
- **State Machine**:
    - `IDLE`: 待机/时钟界面。
    - `MENU`: 主功能菜单。
    - `FOCUS`: 专注模式 (倒计时)。
    - `LIST`: 任务检查单。

### 2.2 专注模式 (Focus Mode)
> 目标：不焦虑的时间感知。
- **Visual**:
    - **不显示秒数倒计时** (No Ticking Clock)。
    - 使用 **环形进度条** 或 **能量槽** (Energy Bar) 随时间递减。
    - 剩余时间 < 5min 时，进度条变红。
- **Light (WS2812B)**:
    - 运行时：淡蓝色呼吸 (Breathing Blue, 4s 周期) -> 镇静。
    - 结束时：彩虹跑马灯 (Rainbow Cycle) -> 奖励。
- **Sound**:
    - 开始：清脆的上行音阶。
    - 结束：柔和的完成音。

### 2.3 任务列表 (To-Do List)
> 目标：动作拆解，单手操作。
- **Interaction**:
    - `UP`/`DOWN`: 切换选中项 (高亮背景)。
    - `OK`: 标记完成 (播放 "Cha-ching" 音效 + 绿色闪烁)。
    - `Back`: 返回上一级。
- **UX Detail**:
    - 列表项不宜超过 5 个。
    - 完成项自动沉底或变暗。

## 3. Phase 3: IoT & Sync (数据同步)
- **Protocol**: MQTT over WiFi.
- **Topics**:
    - `pub /device/{id}/status`: 上报当前状态 (Focusing, Idle) 和电量。
    - `pub /device/{id}/event`: 上报关键事件 (TaskComplete, FocusStart)。
    - `sub /device/{id}/cmd`: 接收云端指令 (SyncTaskList, UpdateConfig).
- **Resilience**:
    - WiFi 断连时，数据暂存本地 (Flash/File)，重连后补传。

## 4. Phase 4: Polish (细节打磨)
- **Deep Sleep**: 无操作 5 分钟后自动息屏，进入轻度睡眠；按任意键唤醒。
- **Exceptions**: 
    - 捕捉 `MemoryError` 并自动重启。
    - 低电量提示 (屏幕闪烁 + 红色呼吸灯)。

## 5. Phase 5: NFC 扩展 (预研)
- **Scenario**: 手机靠近设备 -> 触发 APP 打开任务详情。
- **Data**: NDEF 格式写入设备 ID 和 配对 Key。
