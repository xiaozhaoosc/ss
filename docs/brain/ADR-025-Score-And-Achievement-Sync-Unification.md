# 架构决策记录 (ADR-025): 儿童星星余额双数据源物理与逻辑强一致性加固

*   **状态**: 获批并实施已部署 (Approved & Implemented)
*   **日期**: 2026-05-29
*   **关联实体**: [[_index_wiki]], [[CHRONICLE]], [[ADR-024-Reward-Redemption-Reject-And-Name-Filling.md]]

---

## 1. 决策背景 (Context)

在“Small Steps”儿童端进行奖励兑换（例如：花费 10 颗星兑换“看动画”）的实际业务测试中，发现了一个严重阻碍核心激励闭环的数据源冲突 Bug：
* **不一致现象**：儿童端界面上清晰地显示当前拥有 **`70`** 颗星星，但在点击兑换 10 颗星的奖品时，系统却弹出 **“积分余额不足”** 的 500 报错，且扣分失败，星星余额长时间停留在 `70` 没有任何扣减变化。

### 根源分析
1. **两端数据源逻辑分裂（逻辑层）**：
   - **家长端与后端扣分校验**：查询的是 `ss_child_score` (可用积分余额表) 中的 `balance` 字段。
   - **儿童端星星显示**：在 Pinia 状态管理 `user.ts` 的 `fetchBalance` 中，儿童角色会去调用 `/child/achievement/stars/{childId}`，后端在 `ChildAchievementServiceImpl.selectTotalStarsByChildId` 里查询的是 `ss_child_achievement` (成就/资产表) 中 `type = 'STAR'`（我的星星）的 `count` 字段。
   两个完全分裂的表，在底层充当了“星星余额”的角色。
2. **扣分同步逻辑遗漏（物理层）**：
   - 在后端的加分业务中，`ScoreServiceImpl.java` 会在加分的同时调用 `syncStarsToAchievement` 将新加的值同步加到 `ss_child_achievement` 的星星 `count` 上。
   - **但在扣分业务 `deductPoints` 中，只扣减了 `ss_child_score` 里的 `balance` 余额，根本没有对 `ss_child_achievement` 的 `count` 进行任何同步扣减！**
   这导致在孩子连续兑换扣分后，`ss_child_score` 里的实际余额早被扣为 `0`，而儿童端看到的 `ss_child_achievement` 里的星星数由于没有同步机制，依然停留在 `70` 没变。这就形成了“有 70 颗星却提示余额不足”的数据坏账。

---

## 2. 方案对比与决策 (Alternatives & Decision)

### 方案 A：让前端儿童端也直接调用 getScore() 接口
*   *分析*：虽然能直接规避，但由于儿童端整体是以“成就/资产”模型（`ChildAchievement`）为核心设计的（如连击天数、勋章都挂在此服务下），强制前端多模块切换 API 接口会增加前端的模块耦合度，且无法修补物理库层面 `ss_child_achievement` 已形成的 STAR count 脏数据问题。

### 方案 B：后端“物理与逻辑双重强一致”同步加固 (选定方案)
*   *分析*：
    1. **逻辑源头归一（逻辑强一致）**：将后端返回儿童星星总数的接口 `/child/achievement/stars/{childId}`（`ChildAchievementServiceImpl.selectTotalStarsByChildId`）直接重构为**关联读取 `ss_child_score` 表中的 `balance` 可用积分余额**。从逻辑源头上确保双端看到的是绝对统一的“单一真理源”。
    2. **物理强同步（物理强一致）**：在 `ScoreServiceImpl.java` 扣减积分（`deductPoints`）的事务中，**同步加上对 `ss_child_achievement` 星星成就的扣减操作**（`syncDeductStarsToAchievement`），保证物理表级别的数据强健性与整洁度。
    3. **物理数据自愈订正**：利用数据库远程订正命令，将不一致的测试脏数据（ID 1002）在物理库上统一调校订正为 `100`，扫清历史坏账，支持立即完整闭环测试。
*   *优点*：彻底根治了双数据源不一致的顽疾，保证了系统逻辑的高置信度。

---

## 3. 具体实施细节 (Implementation Details)

### 3.1 逻辑源头归一
在 [ChildAchievementServiceImpl.java](file:///home/ken4zhao/Documents/office/jushuang1/github/ss/smallsteps-api/smallsteps-modules/smallsteps-child/src/main/java/com/kenzhao/smallsteps/child/service/impl/ChildAchievementServiceImpl.java) 中注入 `ChildScoreMapper` 并改写：
```java
    @Override
    public Integer selectTotalStarsByChildId(Long childId) {
        com.kenzhao.smallsteps.common.ss.domain.ChildScore score = scoreMapper.selectOne(
            new com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<com.kenzhao.smallsteps.common.ss.domain.ChildScore>()
                .eq(com.kenzhao.smallsteps.common.ss.domain.ChildScore::getUserId, childId));
        return score != null ? score.getBalance() : 0;
    }
```

### 3.2 物理扣分同步补全
在 [ScoreServiceImpl.java](file:///home/ken4zhao/Documents/office/jushuang1/github/ss/smallsteps-api/smallsteps-modules/smallsteps-child/src/main/java/com/kenzhao/smallsteps/child/service/impl/ScoreServiceImpl.java) 的 `deductPoints` 中注入同步扣减：
```java
        // 更新积分
        childScore.setBalance(childScore.getBalance() - points);
        childScoreMapper.updateById(childScore);
        
        // 同步扣除成就表中的星星数量 (物理强一致加固)
        syncDeductStarsToAchievement(userId, points);
```
并在类末尾实现物理扣减逻辑：
```java
    private void syncDeductStarsToAchievement(Long childId, int points) {
        com.kenzhao.smallsteps.common.ss.domain.ChildAchievement stars = childAchievementMapper.selectOne(
            new com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<com.kenzhao.smallsteps.common.ss.domain.ChildAchievement>()
                .eq(com.kenzhao.smallsteps.common.ss.domain.ChildAchievement::getChildId, childId)
                .eq(com.kenzhao.smallsteps.common.ss.domain.ChildAchievement::getType, "STAR"));

        if (stars != null) {
            int newCount = stars.getCount() - points;
            stars.setCount(Math.max(0, newCount));
            childAchievementMapper.updateById(stars);
        }
    }
```

### 3.3 数据库存量自愈订正
在远程 Postgres 物理集群中对测试用户（儿童ID 1002）执行了以下 SQL 调校订正：
```sql
UPDATE ss_child_score SET balance = 100, total_earned = 100 WHERE user_id = 1002;
UPDATE ss_child_achievement SET count = 100 WHERE child_id = 1002 AND type = 'STAR';
```

---

## 4. 架构与激励影响 (Consequences)

1.  **绝不分裂的“单一真理源”**：儿童端显示的星星数与可用积分余额完美统一，且兑换打卡消费后两表数据完美物理级同步，再无数据不同步而造成的“有星无法兑换”的心智障碍。
2.  **存量坏账完美清空**：测试数据（1002 孩子）已在物理库直接自愈充值 100 颗星星，可以顺畅地进行 10 颗星看动画、或者任意奖励的即时兑换与全流程体验。
3.  **零前端侵入**：完全由后端数据统一层做高能效收拢，前端不需要任何修改，完美的无感式升级。
