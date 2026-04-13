# AOT Layout Strategy: 高性能异步文本排版

本项目引入 "AOT (Ahead-of-Time) Layout" 策略，灵感来源于 `chenglou/pretext`。核心理念是将昂贵的“文本测量与分析”与低廉的“视口渲染”彻底解耦。

## 1. 核心架构 (The Two-Phase Architecture)

### Phase A: Prepare (准备阶段)
当任务数据（文字、规则、故事）更新或字体设置变更时，在后台或非 UI 线程触发。
1.  **分词与段落化 (Segmentation)**: 将 UTF-8 字符串拆分为“原子级”段落（Words 或 Graphemes）。
2.  **测量与缓存 (Measurement)**: 调用字体引擎获取每个原子的宽度。
3.  **计算换行索引 (Break Calc)**: 根据当前容器宽度（如 128px），计算出每一行的起始/截止索引。
4.  **生成布局句柄 (Layout Handle)**: 输出一个轻量级的 `LayoutIndex` 结构体。

### Phase B: Layout/Render (渲染阶段)
在 UI 刷新循环中触发。
1.  **按需取值**: 只根据当前 `scrollY` 值，检索 `LayoutIndex` 中处于视口内的行。
2.  **像素绘制**: 直接根据预存的索引进行 `fillText`，无需再次计算换行或测量宽度。

---

## 2. 硬件实现方案 (ESP32-S3 / C++)

在 ESP-IDF 环境下，我们将该思想落实为如下模式：

```cpp
/**
 * @brief 布局行信息，极轻量化
 */
struct SATS_LineInfo {
    uint16_t start_offset; // 原始字符串中的偏移
    uint16_t length;       // 该行的字符长度
    uint16_t visual_width; // 预计算的实际宽度 (可选)
};

/**
 * @brief 预计算的布局索引容器
 */
class SATS_PreparedText {
public:
    std::vector<SATS_LineInfo> lines;
    uint32_t total_height;
    
    // 构造函数触发 Phase A
    SATS_PreparedText(const char* text, uint16_t max_width, SATS_Font* font);
};
```

**关键点**：
- **内存平衡**: 在 128x160 屏上，如果文字较长（超过 100 行），建议只缓存 `SATS_LineInfo` 而不缓存渲染后的 Bitmap。
- **平滑滚动**: 借助预计算的总高度 `total_height`，UI 可以实现无缝的像素级惯性滚动，而不会在滚动到新行时产生计算抖动。

---

## 3. 跨端一致性 (App / JS)

为确保家长在 App 上预览的“任务卡片”与孩子在硬件上看到的 100% 一致：
- **排版协议模拟**: App 侧将使用模拟硬件 DPI 和字体度量衡的 `pretext` 逻辑。
- **防溢出校验**: 当家长输入文本时，App 实时调用 `layout()` 预测硬件端所需的行数。如果超过 5 行（容器上限），自动提示“文字将分屏显示”。

---

## 4. ADHD 友好性分析

- **零延迟 (Zero Jank)**: ADHD 儿童对等待和界面停顿极度敏感。AOT 布局消除了一切因排版引起的性能掉帧。
- **一致性 (Consistency)**: 跨端排版一致性能建立孩子的信任感，避免因 App 和硬件显示不一导致的挫败感。

---
> [!TIP]
> **设计准则**：宁可在进入页面前多 50ms 的“准备时间”，也不要在滚动时产生 5ms 的“掉帧”。
