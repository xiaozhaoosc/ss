# Small Steps App 文档

## 项目概述

Small Steps App 是 Small Steps 系统的移动端应用，基于 UniApp X（Vue3 + UTS）开发，为家长和儿童提供任务管理、奖励系统、情绪管理等功能。

### 核心功能

- **儿童端**：
  - 任务执行与进度跟踪
  - 奖励兑换与成就系统
  - 沉浸式游戏化体验
  - 与硬件设备互动

- **家长端**：
  - 任务创建与管理
  - 奖励配置
  - 数据分析与洞察
  - 设备管理

## 技术栈

- **框架**：UniApp X
- **前端**：Vue3 + TypeScript
- **样式**：Tailwind CSS
- **状态管理**：Vuex
- **网络请求**：axios
- **本地存储**：uni.storage
- **BLE 通信**：uni-ble

## 项目结构

```
smallsteps-app/
├── src/
│   ├── api/           # API 接口
│   ├── components/    # 组件
│   │   ├── child/     # 儿童端组件
│   │   ├── parent/    # 家长端组件
│   │   └── common/    # 通用组件
│   ├── pages/         # 页面
│   │   ├── child/     # 儿童端页面
│   │   ├── parent/    # 家长端页面
│   │   ├── login/     # 登录注册页面
│   │   └── mine/      # 个人中心页面
│   ├── plugins/       # 插件
│   ├── static/        # 静态资源
│   ├── store/         # 状态管理
│   └── utils/         # 工具函数
├── docs/              # 文档目录
├── package.json       # 项目配置
└── vite.config.js     # Vite 配置
```

## 快速开始

### 环境要求

- Node.js 16+
- npm 7+
- HBuilderX（推荐）或 VS Code

### 本地开发

1. **克隆代码**

```bash
git clone <repository-url>
cd smallsteps-app
```

2. **安装依赖**

```bash
npm install
```

3. **启动开发服务**

使用 HBuilderX：
- 打开项目
- 点击 "运行" -> "运行到浏览器"

使用 VS Code：

```bash
npm run dev
```

4. **打包构建**

```bash
# 构建 H5 版本
npm run build:h5

# 构建微信小程序版本
npm run build:mp-weixin

# 构建 App 版本
npm run build:app
```

## 页面结构

### 儿童端页面

- **首页**：任务列表、快捷入口
- **任务执行**：任务步骤展示、进度跟踪
- **奖励商店**：积分兑换奖励
- **头像编辑器**：个性化头像设置

### 家长端页面

- **仪表盘**：数据概览、快捷操作
- **任务创建**：创建和配置任务
- **奖励配置**：设置奖励内容和积分
- **情绪详情**：儿童情绪分析和建议
- **设备配置**：硬件设备管理
- **数据分析**：行为数据可视化

## 开发指南

### 代码规范

- 遵循 Vue 代码规范
- 使用 ESLint + Prettier 保持代码风格一致
- 组件命名使用 PascalCase
- 变量命名使用 camelCase

### 开发流程

1. 从 `develop` 分支创建功能分支
2. 编写代码和测试
3. 提交代码并创建 Pull Request
4. 代码审查
5. 合并到 `develop` 分支

### 最佳实践

- **组件化开发**：将重复使用的 UI 元素封装为组件
- **状态管理**：使用 Vuex 管理全局状态
- **API 封装**：统一封装 API 请求，处理错误和拦截器
- **性能优化**：合理使用 `v-if` 和 `v-show`，避免不必要的渲染
- **用户体验**：遵循 UX 设计规范，确保界面简洁易用

## 部署指南

### H5 部署

1. 构建 H5 版本：

```bash
npm run build:h5
```

2. 将 `dist/build/h5` 目录部署到 Web 服务器。

### 小程序部署

1. 构建小程序版本：

```bash
npm run build:mp-weixin
```

2. 在微信开发者工具中导入 `dist/build/mp-weixin` 目录
3. 提交审核并发布

### App 部署

1. 使用 HBuilderX 打开项目
2. 点击 "发行" -> "原生 App-云打包"
3. 配置打包参数并提交
4. 下载安装包并发布

## 常见问题

### Q: 运行项目时出现依赖错误怎么办？

**A:** 尝试删除 `node_modules` 目录并重新安装依赖：

```bash
rm -rf node_modules
npm install
```

### Q: 如何添加新页面？

**A:** 按照以下步骤：
1. 在 `src/pages` 目录下创建新页面目录
2. 在 `pages.json` 中注册页面
3. 在 `src/api` 中添加对应的 API 接口
4. 在 `src/store` 中添加相关状态管理

### Q: 如何与硬件设备通信？

**A:** 使用 `src/utils/ble-manager.js` 中的 BLE 管理工具：

```javascript
import { connectDevice, sendCommand } from '@/utils/ble-manager';

// 连接设备
connectDevice(deviceId).then(() => {
  console.log('设备连接成功');
});

// 发送命令
sendCommand(deviceId, command).then(() => {
  console.log('命令发送成功');
});
```

## 贡献指南

1. Fork 项目
2. 创建功能分支
3. 提交更改
4. 创建 Pull Request

## 许可证

[MIT License](LICENSE)
