# ESP32 UI Framework (MicroPython)

本项目基于 MicroPython 构建了一套专为 1.8 寸 (128x160) 屏优化的 UI 框架。

## 1. 核心模型 (App & Page)

### App 类 (`base.py`)
全局容器，管理帧缓冲区 (`framebuf`) 和页面切换。
- **刷新机制**: `refresh_display()` 将 128x160 的 RGB565 缓冲区通过 SPI 推送至 ST7735 驱动。
- **输入分发**: 接管物理按键 (UP/DOWN/OK/BACK) 并路由至当前活跃页面。

### Page 类 (`base.py`)
所有 UI 页面的基类。
- **生命周期**:
    - `on_enter()`: 页面进入时初始化数据。
    - `on_exit()`: 页面销毁前清理资源。
    - `draw()`: 核心渲染逻辑。
    - `update()`: 每一帧循环调用，处理动画或定时任务。
- **标准组件**: 内置 `draw_status_bar()` 提供统一的电量、时间、Wi-Fi 状态栏。

## 2. 文本排版系统 (`layout.py`)

为了在极低 RAM 环境下处理长文本，引入了 `SlidingWindowLayout`：
- **混宽支持**: 自动处理 8px (ASCII) 与 16px (中文字符) 的垂直对齐与换行。
- **滑动窗口**: 仅维护可见区域及其周边的行索引。
- **AOT (Ahead-of-Time)**: 滚动前已完成换行计算。

## 3. 渲染工具链 (`render_utils.py`)

- **`draw_mixed_text()`**: 核心渲染函数。
    - ASCII 字符直接调用 `fb.text()`。
    - 中文字符调用 `font_mini.py` 中的位图数据手动绘制 (`pixel` 级或 `blit` 级逻辑)。

## 4. UI 设计准则 (ADHD 友好)

1.  **高对比度**: 默认深色底 (`0x0000`) 高亮文字 (`0xFFFF`)。
2.  **大间距**: 列表项高度不小于 20px，行间距建议 18px。
3.  **即时反馈**: 所有按键操作必须伴随视觉更新或物理反馈（震动/灯光）。
