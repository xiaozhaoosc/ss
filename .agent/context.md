# 项目上下文

## 业务概览
**"Small Steps (小步)"** 是一款专为 ADHD 儿童设计的行为习惯辅助系统。旨在通过“物理伴侣 + 游戏化激励”的模式，帮助儿童将外部辅助内化为自身能力。
核心理念：**"Cognitive Ease & Emotional Warmth"**（认知极简与情感温润）。

## 系统架构
项目由三个核心子系统构成：
1.  **硬件终端 (The Anchor)**
    *   **核心**: ESP32-S3 驱动的实体玩偶。
    *   **交互**: 1.8寸 ST7735 屏幕 (128x160)，4个物理按键，WS2812B 灯环，NFC。
    *   **功能**: 专注模式 (光语/声语)、任务提醒、NFC 互动。
2.  **移动端 App (The Companion)**
    *   **技术栈**: **UniApp X** (Vue3 + UTS)。
    *   **模式**:
        *   **儿童端**: 游戏化激励，沉浸式体验 (Nunito 字体, Bouncy 动效)。
        *   **家长端**: 数据看板，任务配置 (系统字体, 清晰高效)。
3.  **管理后台 (The Brain)**
    *   **技术栈**: **Nuxt 3**。
    *   **功能**: 全局数据大盘、Prompt 模板配置、用户管理。

## 关键文档
- **UI 设计规范**: `docs/UI_app/README.md` (包含双端设计准则)
- **产品定义 (PM)**: 见 Agent Rule `MEMORY[PM.md]` (渐进式辅助，儿童尊严优先)
- **UX 设计**: 见 Agent Rule `MEMORY[UX 设计师.md]` (认知卸载，容错设计)

## 实施原则
遵循 **Human 3.0 中文原生协议**。
- **语言**: 思考与输出强制中文。
- **核心**: 本质主义，代码即负债。
- **风格**: 专业权威，直接解决痛点。

## 路线图与进度追踪 (Roadmap)

### 1. 基础架构 Phase 1 (已完成 ✅)
- [x] Bluetooth A2DP Source 核心重构
- [x] 自动搜寻 (RSSI 过滤) 与即时重连逻辑
- [x] 手动选择设备 UI (1.8 寸屏适配)
- [x] **归档同步**: 见 `archive/20260321`

### 2. 双向音频 Phase 2 (进行中 [/])
- [ ] **HFP Client 集成**: 支持耳机麦克风采集
- [ ] **音频流拓扑优化**: A2DP 与 HFP 协同工作
- [ ] **低延迟语音流**: 结合 Vosk/Silero 调研成果

### 3. ADHD 业务逻辑 Phase 3 (待启动 [ ])
- [ ] 任务拆解引擎实现
- [ ] 游戏化勋章与勇气碎片系统
- [ ] 家长端实时同步接口

### 4.项目的运行配置与脚本：

```
 java -jar .\smallsteps-admin.jar --spring.profiles.active=dev --server.port=8081 --file.encoding=UTF-8 --DB_HOST=10.8.0.1 --DB_PORT=15432 --DB_NAME=smallsteps_db --DB_USER=smallsteps --DB_PASS=abdSSsaf#1236548^ --REDIS_HOST=10.8.0.1 --REDIS_PORT=6379 --REDIS_PASS=abdSSsaf#1236548^ --spring.boot.admin.client.username=admin --spring.boot.admin.client.password=abdSSsaf#1236548^ --monitor.username=admin --monitor.password=abdSSsaf#1236548^
 ```
---
**提示**: 每次开启对话时，请阅读 `archive/` 目录下最新的演示报告以获取详细上下文。
