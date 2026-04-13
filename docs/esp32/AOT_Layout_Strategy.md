# AOT Layout Strategy: 高性能异步文本排版

本项目引入 "AOT (Ahead-of-Time) Layout" 策略。核心理念是将昂贵的“文本测量与分析”与低廉的“视口渲染”彻底解耦，针对 ESP32-S3 的有限资源进行极致优化。

## 1. 核心架构 (The Two-Phase Architecture)

### Phase A: Prepare (准备阶段)
1.  **分词与段落化 (Segmentation)**: 将 UTF-8 字符串拆分为段落和原子。
2.  **测量与缓存 (Measurement)**: 
    - **Bitmap Font 优化**: 标准化使用 **Fixed-Pitch Bitmap Font**。
    - **计算简化**: 由于是固定字阶，宽度测量简化为 $Width = CharCount \times FixedWidth$。对于混宽（中文 16px，英文 8px），采用加权累加。
3.  **窗口式滑动预计算 (Sliding Window Break Calc)**:
    - **内存平衡策略**: 仅对“当前可见屏 + 前一屏 + 后一屏”进行换行计算（约 30 行数据）。
    - **动态加载**: 当用户滚动接近当前预计算块的边缘时，后台触发下一块的异步计算。

### Phase B: Layout/Render (渲染阶段)
- **视口感知**: 只渲染视口范围内的 `LineInfo`。
- **流畅度保证**: 窗口式滑动确保了内存占用恒定，避免了长文档导致的内存溢出。

---

## 2. 硬件实现方案 (MicroPython / C++)

在 MicroPython 环境下，该逻辑由 `SlidingWindowLayout` 类实现：

```python
class SlidingWindowLayout:
    def __init__(self, text, max_width=128):
        self.text = text
        # ... 初始化逻辑
        
    def update_window(self, start_line_idx):
        # 预计算 30 行的起始偏移量并存入 buffer
        pass
```

---

## 3. 跨端一致性 (App / JS)

- **直接引入**: `smallsteps-app` 将直接引入 `@chenglou/pretext` 库。
- **渲染模拟**: 在 App 端配置 `pretext` 模拟硬件侧的点阵排版规则，确保家长预览与孩子看到的内容 100% 一致。

---

## 4. ADHD 友好性设计

- **零延迟 (Zero Jank)**: 消除翻页和滚动的掉帧，降低感官焦虑。
- **一致性 (Consistency)**: 建立孩子对设备的“可预测性”信任感。

---
> [!IMPORTANT]
> **设计准则**：严禁在绘制循环 (`draw_callback`) 中进行任何形式的字符串宽度计算。所有布局偏移必须由 Pre-calc 给出。
