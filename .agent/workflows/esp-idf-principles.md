---
description: ESP-IDF 开发与调试核心原则 (Human 3.0 Protocol 扩展)
---

# ESP-IDF 零信任与系统性排错原则 (The Zero-Trust & Systemic Debugging Principles)

基于对之前“挤牙膏式”修复编译错误的惨痛教训，特将以下经验上升为 ESP-IDF 开发与重构强制工作流。在当前系统及任何 AI Agent 介入时，必须无条件遵循以下纪律。

## 1. 动态版本认知与 API 零信任 (Zero-Trust API)
**痛点回顾**：曾经因为过度依赖旧版本（v4.x）的经验记忆，盲目调用已经废弃或发生签名的函数（如 `esp_a2d_source_data_raw_write`，或是将旧枚举当作新版使用），导致编译频繁失败。

**强制动作 (Mandatory Action)**：
- **拒绝常识臆造**：每次调用 ESP-IDF 的底层 API（蓝牙、I2S、LCD 等），在写代码**之前**，强制使用文件搜索（如 `grep_search` 或直接查看 `view_file`）读取开发机本地的具体 `esp-idf/components` 目录下的真实 `.h` 文件，确认其实际方法签名。
- **匹配当前契约**：无论外界教程如何，以本地 IDF 工具链声明的 C 语言头文件为终极契约。

## 2. 严禁局部挤牙膏式修补 (Holistic Static Analysis)
**痛点回顾**：之前遇到编译错误，只解决当前报出的一行错误，然后再跑一次长达几分钟的编译。例如 `CMakeLists.txt` 遗漏、Private/Public 权限错误、头文件 `#include` 被错误地放在类定义内部导致找不到 `Undefined Reference` 链接报错。这些问题本可以一眼看穿。

**强制动作 (Mandatory Action)**：
当引入一个新模块或发生长链接报错时，必须进行“三维静态分析”：
1. **构建层 (Build System)**：立刻检查目标 `.cc`/`.c` 是否被写入 `CMakeLists.txt`（包含路径是否更新）。
2. **连接层 (Linker & Logic)**：检查类的定义文件，确保头文件 `#include` 是位于文件顶部的全局空间，绝不将其套在其他 Class 或 Namespace 内部。
3. **依赖层 (Dependency)**：对新调用的其他模块，确认对方的实现是否存在（如是否调用了桩函数或未定义方法）。

## 3. 本地编译闭环补救与人工降级 (Addressing Broken Feedback Loops)
**痛点回顾**：当 AI Agent 无法正确激活主机的特定 Conda 或 PowerShell 虚拟环境时，无法自动化调用 `idf.py build`，导致把人类降级为了“人肉编译器”。

**强制动作 (Mandatory Action)**：
- 首先尝试构建独立的命令行闭环（例如通过 `cmd.exe /c "export.bat && idf.py build"` 来绕过 PS 的限制）。
- 若识别到由于环境冲突无法构建自动编译闭环，Agent 必须启动**“防御性降级”**：停止所有的“试错型代码更改”。所有后续的代码必须经过极度审慎的依赖树静态梳理，通过肉眼检查所有的类映射和依赖逻辑，力求“提交即绿灯”，最大化减少人类去按编译键的次数。

## 4. 日志审计 (Log Audit Rule)
如果是 C++ ESP-IDF 开发，报错绝不止于首行的可见错误。在审阅用户的 `build.log` 时：
## 5. UI 极致流畅度与文本排版原则 (AOT Layout Principle)
**痛点回顾**：在高频率滚动的列表或长文本显示中，实时进行换行计算（Word Wrap）和字体度量（Metric calculation）会占用大量 CPU 周期，导致界面卡顿，增加 ADHD 儿童的焦虑感。

**强制动作 (Mandatory Action)**：
- **解耦测量与渲染**：引入 `chenglou/pretext` 的 **Two-Phase Architecture**。在数据合规或初始化时完成 `Prepare`（计算行索引、断句、缓存宽度），严禁在绘制循环 (`draw_callback`) 中进行任何复杂的字符串扫描。
- **像素级平滑设计**：利用预计算的总高度（total_height）实现无缝像素滚动，而非基于“行”的粗糙跳转。
- **跨端一致性校验**：所有涉及硬件显示的 UI 组件，必须参考 [AOT_Layout_Strategy.md](file:///d:/office/jushuang1/github/ss/docs/brain/AOT_Layout_Strategy.md) 定义的协议，确保 App 端的预览效果与硬件 1:1 对齐。
