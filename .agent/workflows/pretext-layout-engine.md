# Workflow: Pretext 极致文本布局工作流 (Web & ESP32)

本工作流旨在指导如何集成并利用 Pretext 引擎实现“零重排（Zero Reflow）”的极致文本布局，特别针对 ADHD 儿童终端的“紧凑气泡（Shrinkwrap）”视觉需求。

---

## 阶段一：方案决策 (Decision Matrix)

在以下场景中，**必须**使用本工作流：
1. **动态缩放气泡**：文本背景需要完美贴合文字（Pixel-Perfect Fitting）。
2. **高频动画 UI**：文字在每帧都在变大变小（如呼吸效果），且不能引起浏览器 Layout 抖动。
3. **硬件资源受限 (ESP32)**：需要在 128x160 屏上预计算文字折行，避免昂贵的实时排版计算。

---

## 阶段二：Web/移动端 App 实现流程

### 1. 资源准备 (The Prepare Stage)
**原则**：将“测量”与“排版”解耦。
- **Action**: 在组件挂载时或文字变更时执行 `prepare`。
- **Code**:
  ```javascript
  import { prepare } from '@chenglou/pretext';
  // 缓存测量结果，避免重复 Canvas 操作
  const preparedText = prepare(content, "bold 14px 'Outfit'");
  ```

### 2. 极致包裹计算 (The Shrinkwrap Stage)
**原则**：利用 `walkLineRanges` 寻找最小包裹宽度。
- **Action**: 执行二分查找算法，找到维持目标行数的最窄宽度。
- **Logic**:
  ```javascript
  const targetLineCount = 2; // 希望折成 2 行
  const tightWidth = walkLineRanges(preparedText, lineHeight, (w) => {
    return layout(preparedText, w, lineHeight).lineCount;
  });
  ```

### 3. 无重排渲染 (The Render Stage)
- **Action**: 将计算出的 `width` 和 `height` 应用于容器，并使用绝对定位。
- **CSS**: `contain: layout size;` (提示浏览器此元素不影响外部布局)。

---

## 阶段三：ESP32 硬件端实现建议 (C/C++ Porting)

由于 ESP32 环境不支持 JS，需将 Pretext 的算法逻辑进行“影子移植（Shadow Porting）”：

### 1. 字体度量预置 (Metric Tables)
- **替代方案**：不使用 Canvas 测量。在 C 代码中，利用 LVGL 或自定义字库的 `glyph_dsc`（字形描述符）建立宽度表。
- **数据结构**：`uint16_t glyph_widths[256]` (或针对 Unicode 的哈希表)。

### 2. 二分查找布局器 (C-Implementation)
- **逻辑移植**：
  ```c
  // 模拟 Pretext 的 walkLineRanges
  int find_tight_width(const char* text, int target_lines) {
      int low = 10, high = MAX_SCREEN_WIDTH;
      int best_w = high;
      while (low <= high) {
          int mid = (low + high) / 2;
          if (calculate_lines(text, mid) <= target_lines) {
              best_w = mid;
              high = mid - 1;
          } else {
              low = mid + 1;
          }
      }
      return best_w;
  }
  ```

### 3. 静态布局预烘焙 (Pre-baking)
- **工作流**：如果内容是静态的（如“成就奖章”），建议在 App 端使用 Pretext 计算好布局坐标，通过 NFC 或 WiFi 直接下发“布局 JSON”给 ESP32，ESP32 仅负责绘制，不负责排版。

---

## 阶段四：ADHD 设计自检 (UX Audit)

- [ ] **视觉稳定性**：文字缩放时是否有跳变？（Pretext 保证了数学上的平滑性）。
- [ ] **边缘留白**：Padding 是否在所有语言（中/英）下保持一致？
- [ ] **对比度**：紧凑包裹后的气泡背景色与文字是否符合 WCAG 标准。

---

## 维护者建议
- **更新频率**：当 `Inter` 或项目核心字体更新时，需重新检查 `prepare` 的基准值。
- **性能监控**：在移动端，确保 `layout` 函数在单个 Frame 内耗时 < 2ms。
