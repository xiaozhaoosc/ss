# NFC 物理交互设计方案 (Direct Digital Artifacts)

> **核心理念**: 将抽象的“任务”变成可触摸的“实体信物” (Tangible Tokens)。
> **目的**: 减少屏幕菜单选择，让孩子通过“碰触”这个仪式感极强的动作来触发行为。

## 1. 玩法设计 (Interaction Design)

我们定义三种类型的实体 Token（可以是贴纸、硬币、卡片）：

### A. 任务启动币 (Task Token)
*   **形态**: 贴在具体物体上的 NFC 贴纸。
*   **场景**:
    *   贴在书桌上 -> 触发 **"Focus Mode: Homework"**
    *   贴在钢琴上 -> 触发 **"Focus Mode: Piano Practice"**
    *   贴在门口 -> 触发 **"Checklist: School Bag"**
*   **交互**:
    *   孩子拿起 ESP32 终端，“碰”一下贴纸。
    *   设备直接进入倒计时界面，跳过菜单选择。

### B. 奖励兑换卡 (Reward Card)
*   **形态**: 家长持有的实体卡片（或手机 NFC）。
*   **场景**:
    *   孩子完成任务，积攒了 50 星星。
    *    Running out of Screen Time? 孩子请求看电视。
    *   家长拿出一张 "15分钟 电视全" 卡片。
    *   孩子刷卡 -> 设备扣除星星 -> 开启 15分钟 自由时间倒计时。

### C. 身份/配置卡 (Cofig Card)
*   **形态**: 手环或特殊吊坠。
*   **场景**:
    *   **快速配网**: 手机写入 WiFi 信息，设备一刷即连。
    *   **身份切换**: 哥哥刷卡切到哥哥的账号，妹妹刷卡切到妹妹的。

---

## 2. 数据定义 (Data Structure)

考虑到 ESP32 资源限制，我们采用 **"ID 索引模式"** (推荐) 而非 "数据存储模式"。即 NFC 标签里只存一个 ID，具体逻辑由云端或本地配置决定。

### 标签数据格式 (NDEF Text Record)
我们统一使用 **NDEF 文本记录**，格式为 `ss://<type>/<payload>`。

| 类型 (Type) | 格式范例 | 说明 |
| :--- | :--- | :--- |
| **任务 (cmd)** | `ss://cmd/start_focus?id=101` | 启动 ID 为 101 的专注任务 (如写作业) |
| **奖励 (rwd)** | `ss://rwd/redeem?id=5&cost=20` | 兑换 ID 为 5 的奖励，扣除 20 积分 |
| **系统 (sys)** | `ss://sys/wifi?s=MyHome&p=123` | 配置 WiFi (SSID=MyHome, Pass=123) |
| **身份 (usr)** | `ss://usr/login?uid=u8823` | 切换用户 |

---

## 3. 手机/手表模拟测试指南 (Prototyping Guide)

在不动用电烙铁连接 RC522 模块之前，我们可以先用手机来**制作**和**测试**这些标签。

### 第一步：准备工具
*   **Android / iPhone**: 下载 App **"NFC Tools"** (免费且好用)。
*   **空白 NFC 标签**: NTAG213 / NTAG215 (淘宝几块钱一堆)。
*   **或者**: 使用两台支持 NFC 的 Android 手机（一台模拟卡，一台读卡）。

### 第二步：制作标签 (Writing Tags)
1.  打开 **NFC Tools** App。
2.  点击 **"Write" (写入)** -> **"Add a record" (添加记录)**。
3.  选择 **"Text" (文本)** (注意：尽量不要选 URL，除非我们想自动拉起浏览器，这里我们只做纯数据读取)。
4.  输入内容：`ss://cmd/start_focus?id=101`
5.  点击 **"Write / x Bytes"**。
6.  将手机靠近空白 NFC 贴纸，听到“滴”声，写入完成。

### 第三步：验证 (Reading Tags)
*   **验证写入**: 用手机重新扫描刚才的贴纸，确保内容显示为纯文本 `ss://cmd/start_focus?id=101`。
*   **模拟测试**: 如果你现在还没有焊接 RC522 到 ESP32：
    *   你暂时无法用 ESP32 读卡。
    *   **替代方案**: 在 Phase 1 开发阶段，我们在 `main.py` 里写死几个按键模拟 NFC 刷卡事件。
    *   *例如*: 按住 "UP" 键 2秒，模拟读取到了 `ss://cmd/start_focus?id=101`，以此来开发后续的 UI 逻辑。

### 第四步：手表模拟 (Advanced)
*   部分智能手表 (Apple Watch / Galaxy Watch) 支持模拟门禁卡。
*   通常需要将手表的 UID 录入到系统（如果我们采用 UID 模式）。
*   **但注意**: 我们的 `ss://...` 数据模式要求标签是可读写的 NTAG 格式，普通手表的模拟门禁卡功能只能模拟 UID，**无法传输 NDEF 数据**。
*   **结论**: 建议前期使用 **NFC 贴纸** 或 **手机模拟卡 (HCE模式)**，不要折腾手表模拟（限制太多）。

---

## 4. 后续开发计划 (Next Steps)

1.  **硬件准备**: 购买 **RC522 (RFID)** 模块 (淘宝 < 5元)。
2.  **驱动移植**: 将 `micropython-mfrc522` 库放入 ESP32。
3.  **业务逻辑**: 在 ESP32 的主循环中增加：
    ```python
    if nfc.is_card_present():
        data = nfc.read_ndef()
        if data.startswith("ss://"):
            handle_nfc_command(data)
    ```

这将是 **Phase 5** 的核心工作。现在建议先专注把屏幕和按键跑通。
