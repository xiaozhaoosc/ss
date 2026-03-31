# 🎨 Small Steps APP UI 设计概要 (Design Brief)

> **状态**: ✅ 已确认 (Verified)
> **设计者**: Antigravity (CXO)
> **目标**: Stitch MCP 生成 / 高保真原型
> **语言**: 🇨🇳 中文优先 (Chinese First)

本作为 Stitch 项目生成的**唯一真理来源 (Source of Truth)**。

---

## 0. 分组策略 (Stitch Grouping)
为了保持项目整洁，Stitch 屏幕生成必须遵循以下命名/分组约定：

*   **家长端 (Parents)**: 统一前缀 `Parent - [页面名]`
    *   *风格*: 💙 专业冷静 (Professional Calm)
*   **儿童端 (Kids)**: 统一前缀 `Child - [页面名]`
    *   *风格*: 💚 游戏化冒险 (Gamified Adventure)

---

## 1. 核心设计建议 (Status: ✅ APPROVED)

您已“拍板”确认以下策略，这将作为开发的铁律：

### 🎨 策略 A: 字体拆分 (Typography)
*   **家长端**: 系统默认 (San Francisco/Roboto) —— *专业、冷静*。
*   **儿童端**: **Nunito** (圆体) —— *低认知压力，高亲和力*。

### 🚀 策略 B: 动效物理学 (Motion)
*   **家长端**: **Spring (僵硬弹簧)** —— *高效响应*。
*   **儿童端**: **Bouncy (Q弹果冻)** —— *多巴胺视觉重量*。

### 🗺️ 策略 C: 导航隐喻 (Navigation)
*   **家长端**: 底部 TabBar。
*   **儿童端**: **沉浸式地图 (Immersive Map)** —— *将功能场景化（奖杯房、任务板），放弃枯燥的列表*。

### 💡 建议 A: 字体差异化 (Typography Strategy)
*   **不确定的点**: 是否两端统一字体？
*   **我的建议**: **拆分字体**。
    *   **家长端**: 使用系统默认 (San Francisco/Roboto) —— *传递专业、冷静、无额外认知负担*。
    *   **儿童端**: 强制引入 **[Nunito](https://fonts.google.com/specimen/Nunito)** 或 **Varela Round** —— *圆润的笔触能显著降低 ADHD 儿童的阅读压力，增加亲和力*。

### 💡 建议 B: 动效物理学 (Motion Physics)
*   **不确定的点**: 动效的夸张程度？
*   **我的建议**:
    *   **家长端**: **Spring (僵硬弹簧)** —— 快速、准确、无回弹。点击即响应。
    *   **儿童端**: **Bouncy (Q弹果冻)** —— 按钮按下有明显的缩放 (`scale: 0.95`)，任务完成有粒子爆炸效果 (Confetti)。*多巴胺需要视觉上的“重量感”反馈*。

### 💡 建议 C: 导航隐喻 (Navigation Metaphor)
*   **我的建议**:
    *   **家长端**: 底部标准 TabBar (Dashboard, Tasks, Insights, Profile) —— *符合成人直觉*。
    *   **儿童端**: **沉浸式地图 (Immersive Map)** 或 **悬浮岛列表** —— *不要 TabBar！TabBar 是无聊的列表。把功能变成场景（如：去“奖杯房”看成就，去“控制台”看任务）*。

---

## 2. 视觉规范 (Visual Tokens)

### 👮‍♂️ Parent Mode (The Coach)
*   **Theme**: `Professional Calm`
*   **Color Palette**:
    *   Primary: `#6C9BD2` (Soft Blue - 疗愈蓝)
    *   Surface: `#FFFFFF` (Pure White)
    *   Background: `#F3F4F6` (Cool Grey 100)
    *   Text: `#1F2937` (Grey 800)
*   **Shape**: `Border-Radius: 8px` (标准圆角)
*   **Components**: 高密度的列表、开关、折线图。

### 👼 Child Mode (The Hero)
*   **Theme**: `Gamified Adventure`
*   **Color Palette**:
    *   Primary: `#8CD0A1` (Mint Green - 生长绿)
    *   Accent: `#F5D76E` (Banana Yellow - 强调/星星)
    *   Background: `#F0F9FF` (Sky Blue 50)
    *   Text: `#111827` (Grey 900 - Black for contrast)
*   **Shape**: `Border-Radius: 20px` (大圆角/药丸形)
*   **Components**: 大卡片、3D 图标、进度条能量槽。

---

## 3. Stitch Prompt 预设

确认上述风格后，我将向 Stitch 发送如下指令集：

```text
Project: Small Steps
Context: ADHD support app with dual interfaces.
Design System: Tailwind CSS

1. Generate "Parent Dashboard": Clean white cards on grey bg. Metrics for "Today's Focus".
2. Generate "Child Home": Gamified "Trophy Room". Large interactive "Current Task" card. Bouncy animations.
```

---

**请确认**:
1.  是否同意 **"字体拆分"** (建议 A)？
2.  是否同意儿童端采用 **"沉浸式场景"** 导航 (建议 C)？（这会增加开发成本，但体验极佳）
