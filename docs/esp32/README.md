# ESP32-S3 Terminal Documentation

欢迎来到 **"Small Steps (小步)"** 硬件终端研发空间。本目录包含了从电路定义到 UI 渲染引擎的所有技术文档。

## 📚 文档列表

### 1. 核心架构与策略
- [**AOT Layout Strategy**](./AOT_Layout_Strategy.md): 针对 ESP32 优化的异步排版与渲染协议。
- [**UI Framework Guide**](./UI_FRAMEWORK.md): 基于 MicroPython 的 `App/Page/Layout` 框架说明。

### 2. 硬件资源
- [**Hardware Configuration**](./HARDWARE_CONFIG.md): 详细的 GPIO 引脚定义、外设协议与配置规范。

### 3. 外设参考资料 (Media)
- [Small Steps 爆炸视图](./small_steps_exploded_view.png)
- [Small Steps 伴侣 Mockup](./small_steps_companion_mockup.png)

---

## 🛠 开发快速入口

### 代码路径
- **驱动与系统**: `smallsteps-esp32/`
- **UI 页面**: `smallsteps-esp32/ui/`
- **资源文件**: `smallsteps-esp32/sounds/`, `smallsteps-esp32/wavs/`

### 核心原則
> [!TIP]
> **儿童尊严优先**。在设计任何交互逻辑时，请务必参考核心准则，确保设备作为“伙伴”而非“监工”存在。
