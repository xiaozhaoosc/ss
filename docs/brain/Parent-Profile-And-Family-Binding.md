# 家长中心与孩子档案绑定流程 [[Parent-Profile-And-Family-Binding]]

## 1. 背景与目标
在 **Small Steps (小步)** 生态中，家长端 App 需要能够清晰展示已绑定的孩子档案，并提供便捷的入口来关联新的设备终端。本模块旨在打通家长与孩子之间的数据链路，实现 1:N 的多角色管理。

## 2. 核心功能实现

### 2.1 家长中心 (Me Page)
- **动态渲染**: 基于 `parentId` 从 `/ss/child/list` 获取实时数据，不再依赖静态 Mock。
- **多感官状态展示**:
    - **年龄自动计算**: 从 `birthday` 字段动态推导。
    - **描述智能解析**: 针对 `remark` 字段，实现了 `Age · Grade` 的组合展示逻辑，能够自动识别备注中的年级信息（如“幼儿园中班”）。
- **设备登录码 (Device QR)**: 预留扫码交互，用于在物理设备上快速登录对应孩子账户。

### 2.2 绑定流程 (Binding Flow)
- **路径**: `pages/parent/family/bind` [[Bind-Child-Flow]]
- **逻辑**: 通过输入孩子端的 `userName` 调用后端 `bindChild` 接口，在 `ss_family_member` 表中建立关联关系。
- **UI 设计**: 遵循 **Cognitive Ease** 原则，使用大输入框和即时反馈。

### 2.3 档案编辑详情 (Edit Profile)
- **路径**: `pages/parent/family/edit`
- **功能**: 支持对孩子昵称、性别、出生日期及备注信息的全量修改。
- **UI 特性**:
    - **性别选择器**: 使用自定义的男孩/女孩图标按钮，符合儿童产品调性。
    - **原生日期选择**: 采用 `uni-app` 原生 Picker，降低输入成本。
    - **表单状态管理**: 实现了从 `getInfo` 加载到 `edit` 保存的完整状态闭环。
- **数据实体**: [[ss_child]]
- **关联逻辑**: 
    - `ss_child.parent_id` 作为主要所有者标识。
    - `ss_family_member` 支持多家长协作（如父母共同管理）。
- **前端工具**: 封装了 `child.ts` 和 `family.ts` API 模块。

## 4. 待办与优化 (TODO)
- [ ] 孩子档案的编辑详情页实现。
- [ ] 绑定流程中增加 NFC 触碰绑定逻辑（硬件支持项）。
- [ ] 备注字段的结构化拆分（从 `jsonb` 提取特定标签）。

---
**相关链接**:
- [[CHRONICLE]]
- [[_index_wiki]]
- [[ss_child]]
