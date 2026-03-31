
<h1 align="center" style="margin: 30px 0 30px; font-weight: bold;">SmallSteps v1.2.0</h1>
<h4 align="center">基于UniApp开发的轻量级移动端框架</h4>

## 平台简介

SmallSteps App 移动解决方案，采用uniapp框架，一份代码多终端适配，同时支持APP、小程序、H5！

## 技术文档

- 官网网站：[http://smallsteps.com](http://smallsteps.com)
- 文档地址：[http://doc.smallsteps.com](http://doc.smallsteps.com)
- H5页体验：[http://h5.smallsteps.com](http://h5.smallsteps.com)
- 小程序体验

 

## 演示图


---

## 🎨 设计 DNA (Design System)

### 设计哲学

Small Steps 采用**双模式设计系统**，针对家长端和儿童端提供差异化的视觉体验：

- **家长端 (Parent Mode)**: **认知极简 (Cognitive Ease)** - 专业、清晰、数据驱动
- **儿童端 (Child Mode)**: **情感温润 (Emotional Warmth)** - 友好、鼓励、游戏化

### 配色系统 (Color Palette)

#### 家长端配色

| 颜色名称 | Hex 值 | 用途 | 示例 |
|---------|--------|------|------|
| **主色调** | `#6C9BD2` | 按钮、链接、强调元素 | ![#6C9BD2](https://via.placeholder.com/15/6C9BD2/000000?text=+) |
| **主色调深色** | `#5a82b0` | Hover 状态、深色模式 | ![#5a82b0](https://via.placeholder.com/15/5a82b0/000000?text=+) |
| **背景色（浅色）** | `#f6f7f8` | 页面背景 | ![#f6f7f8](https://via.placeholder.com/15/f6f7f8/000000?text=+) |
| **背景色（深色）** | `#14191e` | 深色模式背景 | ![#14191e](https://via.placeholder.com/15/14191e/000000?text=+) |
| **表面色（浅色）** | `#ffffff` | 卡片、弹窗 | ![#ffffff](https://via.placeholder.com/15/ffffff/000000?text=+) |
| **表面色（深色）** | `#1e242b` | 深色模式卡片 | ![#1e242b](https://via.placeholder.com/15/1e242b/000000?text=+) |

#### 儿童端配色

| 颜色名称 | Hex 值 | 用途 | 示例 |
|---------|--------|------|------|
| **薄荷绿** | `#8CD0A1` | 主要交互元素、成功状态 | ![#8CD0A1](https://via.placeholder.com/15/8CD0A1/000000?text=+) |
| **阳光黄** | `#F5D76E` | 奖励、积分、高亮 | ![#F5D76E](https://via.placeholder.com/15/F5D76E/000000?text=+) |
| **靛蓝色** | `#6366f1` | 辅助色、特殊标记 | ![#6366f1](https://via.placeholder.com/15/6366f1/000000?text=+) |
| **背景色（浅色）** | `#f0fdf4` | 页面背景（薄荷绿调） | ![#f0fdf4](https://via.placeholder.com/15/f0fdf4/000000?text=+) |
| **背景色（深色）** | `#1e293b` | 深色模式背景 | ![#1e293b](https://via.placeholder.com/15/1e293b/000000?text=+) |

### 字体系统 (Typography)

#### 家长端字体

- **字体家族**: `Manrope`, `Inter`, `sans-serif`
- **特点**: 现代、专业、易读
- **字号规范**:
  - 标题: `20px` (font-weight: 600)
  - 正文: `14px` (font-weight: 400)
  - 小字: `12px` (font-weight: 400)

#### 儿童端字体

- **字体家族**: `Nunito`, `sans-serif`
- **特点**: 圆润、友好、大字号
- **字号规范**:
  - 标题: `26px` (font-weight: 700)
  - 正文: `16px` (font-weight: 600)
  - 小字: `14px` (font-weight: 500)

### 圆角规范 (Border Radius)

| 尺寸 | 值 | 用途 |
|------|-----|------|
| **小** | `6px` | 按钮、标签 |
| **中** | `12px` | 卡片、输入框 |
| **大** | `16px` | 弹窗、大卡片 |
| **超大** | `24px` | 儿童端特殊元素 |

### 间距系统 (Spacing)

基于 **8px 网格系统**：

- **xs**: `4px`
- **sm**: `8px`
- **base**: `12px`
- **md**: `16px`
- **lg**: `24px`
- **xl**: `32px`
- **2xl**: `48px`

### 组件设计规范

#### 1. TopBar（顶部导航栏）

**家长端**:
- 背景: 纯白 `#ffffff`
- 边框: 底部 1px `#e5e7eb`
- 标题: `17px`, `font-weight: 600`, `#111827`
- 返回按钮: `#6C9BD2`

**儿童端**:
- 背景: 渐变 `linear-gradient(135deg, #8CD0A1, #F5D76E)`
- 标题: `17px`, `font-weight: 700`, `#ffffff`
- 返回按钮: `#ffffff`

#### 2. BottomNav（底部导航栏）

**家长端**:
- 背景: `#ffffff`
- 边框: 顶部 1px `#e5e7eb`
- 激活状态: 图标和文字变为 `#6C9BD2`
- 图标尺寸: `24px`
- 文字尺寸: `10px`

**儿童端**:
- 背景: 渐变 `linear-gradient(to right, #f0fdf4, #fef3c7)`
- 边框: 顶部 1px `#8CD0A1`
- 激活状态: 图标放大 1.2 倍，文字变为 `#8CD0A1`
- 图标尺寸: `24px`
- 文字尺寸: `10px`

#### 3. 按钮设计

**家长端按钮**:
```scss
.parent-button {
  background: #6C9BD2;
  color: #ffffff;
  border-radius: 8px;
  padding: 12px 24px;
  font-size: 14px;
  font-weight: 600;
  
  &:hover {
    background: #5a82b0;
  }
  
  &:active {
    opacity: 0.8;
  }
}
```

**儿童端按钮**:
```scss
.child-button {
  background: linear-gradient(135deg, #8CD0A1, #F5D76E);
  color: #ffffff;
  border-radius: 16px;
  padding: 16px 32px;
  font-size: 16px;
  font-weight: 700;
  box-shadow: 0 4px 12px rgba(140, 208, 161, 0.3);
  
  &:active {
    transform: scale(0.95);
  }
}
```

### 交互原则

#### 家长端交互

1. **微妙反馈**: Hover 状态颜色加深，点击透明度降低
2. **快速响应**: 过渡动画 `0.2s ease`
3. **清晰状态**: 明确的激活、禁用、加载状态

#### 儿童端交互

1. **夸张反馈**: 点击时元素缩放 `scale(0.95)`
2. **欢快动画**: 过渡动画 `0.3s ease`，使用弹性效果
3. **即时奖励**: 完成操作后立即显示庆祝动画

### 暗黑模式 (Dark Mode)

通过 `class="dark"` 切换，自动应用深色配色方案：

- 家长端: 专业深色，降低对比度
- 儿童端: 保持明亮感，使用深色背景 + 鲜艳前景

### 无障碍设计 (Accessibility)

- **对比度**: 所有文字与背景对比度 ≥ 4.5:1
- **触摸目标**: 最小 44x44px（符合 WCAG 2.1）
- **儿童友好**: 大按钮、清晰图标、简化文字

### 响应式设计

- **移动优先**: 基础样式针对移动端
- **平板适配**: 使用 `@media (min-width: 768px)`
- **桌面优化**: 使用 `@media (min-width: 1024px)`

### 设计工具集成

本项目已集成 **Google Stitch MCP Server**，可直接使用 AI 生成符合设计系统的界面：

```
使用 Stitch 生成一个家长端任务列表页面，遵循 Small Steps 设计 DNA
```

详见：[Stitch MCP 使用指南](../../docs/tools/stitch_mcp_guide.md)

---

## 📚 相关文档

- [MCP Toolbox 配置指南](../../docs/tools/mcp_toolbox_guide.md)
- [MCP Postgres 配置指南](../../docs/tools/mcp_postgres_config.md)
- [Stitch MCP 使用指南](../../docs/tools/stitch_mcp_guide.md)

