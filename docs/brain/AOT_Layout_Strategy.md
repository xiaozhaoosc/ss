# AOT Layout Strategy: 高性能异步文本排版

本项目引入 "AOT (Ahead-of-Time) Layout" 策略，灵感来源于 `chenglou/pretext`。核心理念是将昂贵的“文本测量与分析”与低廉的“视口渲染”彻底解耦。

## 1. 核心架构 (The Two-Phase Architecture)

### Phase A: Prepare (准备阶段)
1.  **分词与段落化 (Segmentation)**: 将 UTF-8 字符串拆分为“原子级”段落。
2.  **测量与缓存 (Measurement - Refined)**: 
    - **Bitmap Font 优化**: 标准化使用 **Fixed-Pitch Bitmap Font**。
    - **计算简化**: 由于是固定字阶，宽度测量由复杂的排版引擎简化为 $Width = CharCount \times FixedWidth$。
3.  **窗口式滑动预计算 (Sliding Window Break Calc)**:
    - **内存平衡策略**: 仅对“当前可见屏 + 前一屏 + 后一屏”进行换行计算（约 30 行数据）。
    - **动态加载**: 当用户滚动接近当前预计算块的边缘时，触发下一块的异步计算。
4.  **生成布局句柄 (Layout Handle)**: 输出轻量级的 `LayoutIndex`。

### Phase B: Layout/Render (渲染阶段)
- **视口感知**: 只渲染视口范围内的 `SATS_LineInfo`。
- **流畅度保证**: 窗口式滑动确保了内存占用恒定，避免了长文档导致的内存溢出。

---

## 2. 硬件实现方案 (ESP32-S3 / C++)

```cpp
/**
 * @brief 窗口式布局管理器
 */
class SATS_SlidingWindowLayout {
    SATS_LineInfo window_buffer[30]; // 仅存储 3 屏的行信息
    uint32_t current_window_start_offset;
    
    void shift_window(ScrollDirection dir); // 滑动窗口更新逻辑
};
```

---

## 3. 跨端一致性 (App / JS)

- **直接引入**: `smallsteps-app` 将直接通过 `npm` 引入 `@chenglou/pretext` 库。
- **渲染模拟**: 在 App 端通过配置 `pretext` 的 `prepare` 参数，完全模拟硬件侧的 Bitmap Font 排版规则，确保预览一致性。

---

## 4. ADHD 友好性分析

- **零延迟 (Zero Jank)**: ADHD 儿童对等待和界面停顿极度敏感。AOT 布局消除了一切因排版引起的性能掉帧。
- **一致性 (Consistency)**: 跨端排版一致性能建立孩子的信任感，避免因 App 和硬件显示不一导致的挫败感。

---
> [!TIP]
> **设计准则**：宁可在进入页面前多 50ms 的“准备时间”，也不要在滚动时产生 5ms 的“掉帧”。
