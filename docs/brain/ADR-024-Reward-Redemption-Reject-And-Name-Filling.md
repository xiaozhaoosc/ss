# 架构决策记录 (ADR-024): 奖励审批拒绝端点兼容性与具体名称关联填充治理

*   **状态**: 获批并实施已部署 (Approved & Implemented)
*   **日期**: 2026-05-29
*   **关联实体**: [[_index_wiki]], [[CHRONICLE]], [[ADR-023-Custom-Tabbar-Icon-Optimization]]

---

## 1. 决策背景 (Context)

在“Small Steps”家长端“可兑换奖励管理”（位于日常焦点与奖励设置中）的兑换审批业务中，存在两项阻碍闭环的体验问题：
1. **拒绝兑换接口 404 崩溃**：当家长点击“拒绝”兑换申请时，系统弹出 404 错误 `No endpoint POST /ssapi/parent/reward/redemption/reject/2060232329673293825.`。
2. **名字硬编码无意义**：“待处理请求”和“兑换历史”列表中，所有兑换项的奖励名称无一例外全部被硬编码显示为了 `'奖品'`（例如：“孩子申请兑换奖品”），无法向家长呈现具体是哪一个奖励项目，极大削弱了奖励机制的精准性。

### 根源分析
1. **前端 API 请求路径与参数分裂**：
   - 在移动端 H5 存在两处 API 拒绝接口定义。`api/parent.ts` 中的 `rejectRedemption(redemptionId, reason)` 会在 Body JSON 中传输参数，对应后端的 `POST /redemption/reject`。
   - 但 `api/reward.ts` 却将接口错误定义成了拼接 URL 的形式：`POST /parent/reward/redemption/reject/{redemptionId}`。
   - 后端 `ParentRewardController.java` 只对外暴露了 `@PostMapping("/redemption/reject")`（配合 `@RequestBody` 并强校验 `reason` 拒绝理由非空）。这直接导致在移动端以 Path 形式调用时报 **404 无法找到端点**，且因为没有提供拒绝理由而会在拦截层报 **拒绝理由不能为空的 500 逻辑拦截**。
2. **多表关联数据漏填**：
   - 兑换审批对应的数据库表 `ss_parent_reward_redemption` 中并未冗余存储 `reward_name`，只有 `reward_id` 外键。
   - 在后端 `ParentRewardRedemptionVo.java` 视图层中虽然备置了 `rewardName` 属性，但是在服务层 `ParentRewardRedemptionServiceImpl.queryPageList` 中，单表分页查出后直接由 MapStruct 进行了转码，**根本没有关联 `ParentReward` 去进行名称字段的填充**。
   - 这直接导致返回的 `rewardName` 字段一直为 `null`，导致前端在 fallback 时无条件全部显示成了 `'奖品'`。

---

## 2. 方案对比与决策 (Alternatives & Decision)

### 方案 A：重构前端所有调用与 API 层，使其强制类型一致
*   *缺点*：需要跨多个 Vue 文件修改 API 导入与方法引用，并且要在前端补充大量的理由输入弹窗（这会加重 ADHD 家长的认知负荷，违背“认知极简”准则）。同时无法容错历史遗留的前端调用习惯。

### 方案 B：后端“绝对宽容”端点兼容与关联查询自动补偿 (选定方案)
*   *分析*：
    1. **后端做全向兼容**：在 `ParentRewardController` 保持原接口不动的基础上，额外**增加一个重载的路由端点** `@PostMapping("/redemption/reject/{redemptionId}")`，直接捕获路径 ID 进行拒绝操作。
    2. **降级宽容处理**：放宽对 `reason` 拒绝理由的严格非空校验。如果前端没有传入理由，后端直接在 Controller 层自动进行自愈填充：`String reason = org.springframework.util.StringUtils.hasText(bo.getReason()) ? bo.getReason() : "家长拒绝了该申请";`。
    3. **关联填充服务增强**：在 `ParentRewardRedemptionServiceImpl.queryPageList` 中，在列表转码完毕后，批量检测 `rewardId`，并通过注入的 `ParentRewardMapper` 自动查出其对于的实际 `ParentReward` 奖励名称（如 "看30分钟电视", "去游乐园一次"）回写进 VO 的 `rewardName` 中。
*   *优点*：100% 前端无感知透明升级，解决 404 与 500 的同时补全了数据链条。

---

## 3. 具体实施细节 (Implementation Details)

### 3.1 控制器双模态路由与宽容处理
我们在 [ParentRewardController.java](file:///home/ken4zhao/Documents/office/jushuang1/github/ss/smallsteps-api/smallsteps-modules/smallsteps-parent/src/main/java/com/kenzhao/smallsteps/parent/controller/ParentRewardController.java) 中重塑了拒绝接口：
```java
    @SaCheckPermission("parent:reward:edit")
    @PostMapping("/redemption/reject")
    public R<Void> reject(@RequestBody com.kenzhao.smallsteps.common.ss.domain.bo.ParentRewardRedemptionBo bo) {
        if (bo.getRedemptionId() == null) {
            return R.fail("兑换ID不能为空");
        }
        String reason = org.springframework.util.StringUtils.hasText(bo.getReason()) ? bo.getReason() : "家长拒绝了该申请";
        return toAjax(redemptionService.reject(bo.getRedemptionId(), reason));
    }

    @SaCheckPermission("parent:reward:edit")
    @PostMapping("/redemption/reject/{redemptionId}")
    public R<Void> rejectWithPath(@PathVariable Long redemptionId) {
        return toAjax(redemptionService.reject(redemptionId, "家长拒绝了该申请"));
    }
```

### 3.2 列表关联填充
在 [ParentRewardRedemptionServiceImpl.java](file:///home/ken4zhao/Documents/office/jushuang1/github/ss/smallsteps-api/smallsteps-modules/smallsteps-parent/src/main/java/com/kenzhao/smallsteps/parent/service/impl/ParentRewardRedemptionServiceImpl.java) 中升级分页查询逻辑：
```java
    @Override
    public TableDataInfo<ParentRewardRedemptionVo> queryPageList(ParentRewardRedemptionBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<ParentRewardRedemption> lqw = Wrappers.lambdaQuery();
        lqw.eq(bo.getUserId() != null, ParentRewardRedemption::getUserId, bo.getUserId());
        lqw.eq(bo.getStatus() != null, ParentRewardRedemption::getStatus, bo.getStatus());
        Page<ParentRewardRedemptionVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        
        // 关联查询填充 rewardName 字段，保障前端今日焦点和兑换历史能够显示真实的奖品名称
        if (result.getRecords() != null && !result.getRecords().isEmpty()) {
            for (ParentRewardRedemptionVo vo : result.getRecords()) {
                if (vo.getRewardId() != null) {
                    ParentReward reward = rewardMapper.selectById(vo.getRewardId());
                    if (reward != null) {
                        vo.setRewardName(reward.getName());
                    } else {
                        vo.setRewardName("未知奖励");
                    }
                }
            }
        }
        
        return TableDataInfo.build(result);
    }
```

---

## 4. 架构影响 (Consequences)

1.  **彻底消灭 404/500 崩溃**：家长无论是在今日焦点的通知还是专门的奖励设置卡片中点击“拒绝申请”，均可 100% 毫无阻塞地审批拒绝。
2.  **具体奖励名称完美呈现**：彻底终结了“奖品”这一缺乏人文关怀的无意义占位符。待处理请求与兑换历史直接高清晰地展示如 “看 30 分钟乐高”、“玩 1 小时游戏” 等具体的惊喜名称，亲子动力反馈链路更加温馨和具体。
3.  **零多余编译污染**：完美继承现有的 Mapper 基础设施，保持纯正的 RuoYi 开发范式。
