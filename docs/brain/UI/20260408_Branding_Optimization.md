# 品牌视觉优化规范 [[20260408_Branding_Optimization]]

- **日期**: 2026-04-08
- **主题**: 统一 Small Steps 项目的视觉心智

## 设计规范

### 1. 登录页背景 (Login Wallpaper)
- **标准**: 采用温润、具亲和力的蓝橙渐变风格，平衡“专业辅助工具”与“儿童教育陪伴”的色调。
- **存储路径**: `src/assets/images/login-background.jpg`
- **生成工具**: AI 绘图预设

### 2. 标识系统 (Iconography)
- **Favicon**: 已同步替换为小步项目的四色星星 Logo。
- **Sidebar Logo**: 统一使用 `src/assets/logo/logo.png`。
- **配置项**: 
  - `VITE_APP_TITLE = Small Steps (小步)`
  - `VITE_APP_LOGO_TITLE = SmallSteps`

### 3. 版权标准化 (Legal & Brand)
- **Footer 格式**: `Copyright © 2025-2026 kenzhao All Rights Reserved.`
- **应用范围**: 登录页面底端、首页系统简介。

## 资源一致性控制
所有视觉资源均已从 `docs/UI_app` 目录同步到各子项目的静态资源目录中，确保移动端 (App)、管理端 (Admin) 以及硬件终端的视觉心智保持一致。
