# Small Steps UI 文档

## 项目概述

Small Steps UI 是 Small Steps 系统的管理后台，基于 Nuxt 3 开发，为管理员提供全局数据大盘、Prompt 模板配置、用户管理等功能。

### 核心功能

- **用户管理**：管理家长和儿童用户账号
- **任务管理**：创建和管理任务模板
- **奖励管理**：配置奖励内容和积分
- **设备管理**：管理硬件设备
- **数据分析**：查看系统数据和统计报表
- **Prompt 管理**：配置 AI 提示词模板

## 技术栈

- **框架**：Nuxt 3
- **前端**：Vue 3 + TypeScript
- **样式**：Tailwind CSS
- **状态管理**：Pinia
- **UI 组件**：Element Plus
- **构建工具**：Vite
- **代码规范**：ESLint + Prettier

## 项目结构

```
smallsteps-ui/
├── src/
│   ├── api/           # API 接口
│   ├── assets/        # 静态资源
│   ├── components/    # 组件
│   ├── directive/     # 指令
│   ├── enums/         # 枚举
│   ├── hooks/         # 钩子
│   ├── lang/          # 国际化
│   ├── layout/        # 布局
│   ├── plugins/       # 插件
│   ├── router/        # 路由
│   ├── store/         # 状态管理
│   ├── types/         # 类型定义
│   ├── utils/         # 工具函数
│   ├── views/         # 页面
│   ├── App.vue        # 应用入口
│   └── main.ts        # 主文件
├── docs/              # 文档目录
├── public/            # 公共资源
├── vite/              # Vite 配置
├── package.json       # 项目配置
└── vite.config.ts     # Vite 配置
```

## 快速开始

### 环境要求

- Node.js 16+
- npm 7+
- 现代浏览器

### 本地开发

1. **克隆代码**

```bash
git clone <repository-url>
cd smallsteps-ui
```

2. **安装依赖**

```bash
npm install
```

3. **启动开发服务**

```bash
npm run dev
```

4. **构建生产版本**

```bash
npm run build
```

5. **预览生产版本**

```bash
npm run preview
```

## 页面结构

### 系统管理

- **用户管理**：用户列表、添加用户、编辑用户
- **角色管理**：角色列表、权限配置
- **菜单管理**：菜单配置、权限设置
- **部门管理**：部门结构管理
- **字典管理**：系统字典配置

### 设备管理

- **设备列表**：查看所有设备
- **设备配置**：配置设备参数
- **设备状态**：监控设备在线状态

### 任务管理

- **任务模板**：创建和管理任务模板
- **任务列表**：查看所有任务
- **任务统计**：任务完成情况统计

### 奖励管理

- **奖励配置**：配置奖励内容和积分
- **积分记录**：查看积分变动记录
- **奖励兑换**：管理奖励兑换请求

### 数据分析

- **数据大盘**：系统数据概览
- **用户分析**：用户活跃度分析
- **任务分析**：任务完成情况分析
- **设备分析**：设备使用情况分析

### Prompt 管理

- **模板列表**：管理 AI 提示词模板
- **模板编辑**：编辑提示词内容
- **模板测试**：测试提示词效果

## 开发指南

### 代码规范

- 遵循 Vue 代码规范
- 使用 ESLint + Prettier 保持代码风格一致
- 组件命名使用 PascalCase
- 变量命名使用 camelCase
- 常量命名使用 UPPER_CASE

### 开发流程

1. 从 `develop` 分支创建功能分支
2. 编写代码和测试
3. 提交代码并创建 Pull Request
4. 代码审查
5. 合并到 `develop` 分支

### 最佳实践

- **组件化开发**：将重复使用的 UI 元素封装为组件
- **状态管理**：使用 Pinia 管理全局状态
- **API 封装**：统一封装 API 请求，处理错误和拦截器
- **路由管理**：使用动态路由和权限控制
- **国际化**：支持多语言切换
- **性能优化**：合理使用 `v-if` 和 `v-show`，避免不必要的渲染
- **响应式设计**：确保在不同设备上的良好体验

## 部署指南

### 本地部署

1. 构建生产版本：

```bash
npm run build
```

2. 将 `dist` 目录部署到 Web 服务器。

### Docker 部署

1. 构建 Docker 镜像：

```bash
docker build -t smallsteps-ui .
```

2. 运行容器：

```bash
docker run -d --name smallsteps-ui -p 80:80 smallsteps-ui
```

### Nginx 配置

```nginx
server {
    listen 80;
    server_name example.com;
    
    location / {
        root /usr/share/nginx/html;
        index index.html;
        try_files $uri $uri/ /index.html;
    }
    
    location /api {
        proxy_pass http://api-server:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
```

## 常见问题

### Q: 运行项目时出现依赖错误怎么办？

**A:** 尝试删除 `node_modules` 目录并重新安装依赖：

```bash
rm -rf node_modules
npm install
```

### Q: 页面加载缓慢怎么办？

**A:** 可以尝试以下优化：
1. 启用路由懒加载
2. 优化图片资源
3. 使用 CDN 加速静态资源
4. 启用 Gzip 压缩

### Q: 如何添加新页面？

**A:** 按照以下步骤：
1. 在 `src/views` 目录下创建新页面组件
2. 在 `src/router` 中注册路由
3. 在 `src/api` 中添加对应的 API 接口
4. 在 `src/store` 中添加相关状态管理

### Q: 如何添加新组件？

**A:** 按照以下步骤：
1. 在 `src/components` 目录下创建新组件
2. 在需要使用的页面中导入并注册组件
3. 测试组件功能

## 贡献指南

1. Fork 项目
2. 创建功能分支
3. 提交更改
4. 创建 Pull Request

## 许可证

[MIT License](LICENSE)
