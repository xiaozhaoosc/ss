# Replayright - 优雅地录制 Playwright 脚本

一个 [Agent 技能 (Agent Skill)](https://agentskills.io) 插件，它允许 AI 编码助手通过 Playwright 自动化控制浏览器，并将每一次操作自动录制为可重放的脚本。

AI 助手在编写可靠的端到端 (e2e) 测试时往往会遇到困难（需要反复猜 DOM、反复报错修改）。Replayright 让测试脚本**一次成型，零错误重试**。

```text
 传统的 AI 驱动 e2e 脚本编写模式           |  Replayright 模式
    :反复的“编写-运行-报错”循环             |      :渐进式探索与实时录制
                                          |
                                          |
    探索步骤 1                            |  探索步骤 1 (步骤自动录制) ─┐
    编写步骤 1                            |       ┌──────────────────┘
    运行步骤 1 ─┐                         |       └► 探索步骤 2 (步骤自动录制) ─┐
 ┌───────────────┘                        |               ┌──────────────────┘
 └► 探索步骤 2                            |               └► 探索步骤 3 (步骤自动录制) ─┐
    编写步骤 2                            |                       ┌──────────────────┘
    运行步骤 1 → 步骤 2 ─┐                |                       └► 探索步骤 4 (步骤自动录制) ─┐
 ┌───────────────────────┘                |  ┌──────────────────────────────────────────────┘
 └► 探索步骤 3                            |  └► 运行 步骤 1 → 步骤 2 → 步骤 3 → 步骤 4 (直接成功)
    编写步骤 3                            |
    运行步骤 1 → 步骤 2 → 步骤 3 ─┐        |
 ┌───────────────────────────────┘        |
 └► 探索步骤 4                            |
    编写步骤 4                            |
    运行步骤 1 → 步骤 2 → 步骤 3 → 步骤 4  |
```

## 安装与设置

向你的 AI Agent 发送以下指令即可安装：

```
Install the replayright skill from https://github.com/EnixCoda/replayright
```
*(如果是中文指令：请从 https://github.com/EnixCoda/replayright 安装 replayright 技能)*

Replayright 遵循 [agent skill](https://agentskills.io) 标准。与任何兼容的 AI 编码助手无缝协作。

## 实战演示

### 单次指令 (One-shot prompt)

给你的 AI 助手下达一个明确的指令，然后看着它自动完成：

```
提示词：使用 replayright 的有头(headed)模式编写一个 e2e 测试，在 https://httpbin.org/forms/post 填写表单测试数据并提交。
```

```text
Agent: 我将启动 replayright 并打开页面。
       > open https://httpbin.org/forms/post
       我能看到一个表单，包含客户姓名、电话、邮箱、披萨尺寸、配料、送货时间和备注等字段。
       > fill input[name="custname"] John Doe
       > fill input[name="custtel"] 555-1234
       > fill input[name="custemail"] john@example.com
       > click input[value="medium"]
       > click input[value="mushroom"]
       > click input[value="onion"]
       > fill input[name="delivery"] 13:00
       > fill textarea[name="comments"] 到了请按门铃
       > click text=Submit order
       表单已提交。响应显示已接收到所有数据。
       > close httpbin-form-submit
       脚本已成功保存至 ~/.replayright/scripts/httpbin-form-submit.js
```

### 渐进式探索 (Progressive exploration)

你也可以一步一步地引导 AI 探索页面——脚本会在这个过程中被自动记录下来：

```text
You:   使用 replayright 探索 https://httpbin.org/forms/post 页面

Agent: > open https://httpbin.org/forms/post
       > observe
       我看到一个表单字段如下: Customer (文本), Telephone (电话),
       E-mail (邮箱), Pizza Size (单选框: small/medium/large),
       Toppings (复选框: bacon/cheese/onion/mushroom),
       Delivery time (时间), 以及 Comments (文本域)。

You:   使用测试数据填写表单并提交

Agent: > fill input[name="custname"] John Doe
       > fill input[name="custtel"] 555-1234
       > fill input[name="custemail"] john@example.com
       > click input[value="medium"]
       > click input[value="mushroom"]
       > click input[value="onion"]
       > fill input[name="delivery"] 13:00
       > fill textarea[name="comments"] 到了请按门铃
       > click text=Submit order
       表单提交成功。

You:   保存脚本

Agent: > close httpbin-form-e2e
       脚本已成功保存至 ~/.replayright/scripts/httpbin-form-e2e.js
```

## 开源协议

MIT