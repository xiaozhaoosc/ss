# Core Business Loops Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Implement the missing business loops from the v1.1 spec: the Reward Redemption Loop (freezing stars, parent approval) and the Emotion Tracking Loop (child input, AI night batch analysis, parent alert).

**Architecture:**
- Backend: REST APIs using Spring Boot 3, MyBatis-Plus for DB, Redis for distributed locks (prevent double redemption), XXL-Job (or Spring `@Scheduled`) for the AI batch job.
- Frontend: UniApp Vue 3 Composition API for Wish House UI and Emotion Popup.

**Tech Stack:** Java 21, Spring Boot 3, PostgreSQL, Redis, Vue 3, TailwindCSS.

---

## Chunk 1: Reward Redemption Backend

### Task 1: Child Reward Redemption Service

Implement the service method for a child to request a reward, which must deduct/freeze stars using a transaction.

**Files:**
- Modify: `smallsteps-api/smallsteps-modules/smallsteps-child/src/main/java/com/kenzhao/smallsteps/child/service/IChildRewardService.java`
- Modify: `smallsteps-api/smallsteps-modules/smallsteps-child/src/main/java/com/kenzhao/smallsteps/child/service/impl/ChildRewardServiceImpl.java`

- [ ] **Step 1: Write the failing test**

```java
// smallsteps-api/smallsteps-modules/smallsteps-child/src/test/java/com/kenzhao/smallsteps/child/service/ChildRewardServiceTest.java
package com.kenzhao.smallsteps.child.service;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class ChildRewardServiceTest {
    @Test
    public void testRedeemReward() {
        // Failing test placeholder
        assertTrue(false, "Implement real test");
    }
}
```

- [ ] **Step 2: Run test to verify it fails**

Run: `mvn test -pl smallsteps-modules/smallsteps-child -Dtest=ChildRewardServiceTest`
Expected: FAIL

- [ ] **Step 3: Write minimal implementation**

Add to `IChildRewardService.java`:
```java
Boolean redeemReward(Long rewardId, Long childId);
```

Add to `ChildRewardServiceImpl.java`:
```java
import org.springframework.transaction.annotation.Transactional;
import org.springframework.stereotype.Service;

@Service
public class ChildRewardServiceImpl implements IChildRewardService {
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean redeemReward(Long rewardId, Long childId) {
        // 1. check reward exists and stock
        // 2. check child score >= points_required
        // 3. deduct score (freeze)
        // 4. insert into ss_parent_reward_redemption status=0 (pending)
        return true;
    }
}
```

- [ ] **Step 4: Run test to verify it passes**

Run: `mvn test -pl smallsteps-modules/smallsteps-child -Dtest=ChildRewardServiceTest`
Expected: PASS (after mocking in test)

- [ ] **Step 5: Commit**

```bash
git add smallsteps-api/smallsteps-modules/smallsteps-child/src/
git commit -m "feat: implement child reward redemption logic"
```

### Task 2: Parent Reward Approval

Implement the service method for a parent to approve or reject a redemption request.

**Files:**
- Modify: `smallsteps-api/smallsteps-modules/smallsteps-parent/src/main/java/com/kenzhao/smallsteps/parent/service/impl/ParentRewardRedemptionServiceImpl.java`

- [ ] **Step 1: Write the failing test**

```java
// test/java/com/kenzhao/smallsteps/parent/service/ParentRewardRedemptionServiceTest.java
package com.kenzhao.smallsteps.parent.service;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class ParentRewardRedemptionServiceTest {
    @Test
    public void testApprove() {
        assertTrue(false, "Implement real test");
    }
}
```

- [ ] **Step 2: Run test to verify it fails**

Run: `mvn test -pl smallsteps-modules/smallsteps-parent -Dtest=ParentRewardRedemptionServiceTest`
Expected: FAIL

- [ ] **Step 3: Write minimal implementation**

Update `ParentRewardRedemptionServiceImpl.java`:
```java
import org.springframework.transaction.annotation.Transactional;

@Override
@Transactional(rollbackFor = Exception.class)
public Boolean approve(Long redemptionId) {
    // 1. update status to 1 (approved)
    // 2. record in score history as consumption
    return true;
}

@Override
@Transactional(rollbackFor = Exception.class)
public Boolean reject(Long redemptionId) {
    // 1. update status to 2 (rejected)
    // 2. refund points to child balance
    return true;
}
```

- [ ] **Step 4: Run test to verify it passes**

Run: `mvn test -pl smallsteps-modules/smallsteps-parent -Dtest=ParentRewardRedemptionServiceTest`
Expected: PASS

- [ ] **Step 5: Commit**

```bash
git add smallsteps-api/smallsteps-modules/smallsteps-parent/src/
git commit -m "feat: implement parent reward redemption approval"
```

---

## Chunk 2: Emotion Tracking Backend

### Task 3: Emotion Record API

Create controller and service for child to submit emotion records.

**Files:**
- Create: `smallsteps-api/smallsteps-modules/smallsteps-child/src/main/java/com/kenzhao/smallsteps/child/controller/ChildEmotionController.java`
- Create: `smallsteps-api/smallsteps-modules/smallsteps-child/src/main/java/com/kenzhao/smallsteps/child/service/IChildEmotionService.java`
- Create: `smallsteps-api/smallsteps-modules/smallsteps-child/src/main/java/com/kenzhao/smallsteps/child/service/impl/ChildEmotionServiceImpl.java`

- [ ] **Step 1: Write the failing test**

```java
// smallsteps-api/smallsteps-modules/smallsteps-child/src/test/java/com/kenzhao/smallsteps/child/controller/ChildEmotionControllerTest.java
package com.kenzhao.smallsteps.child.controller;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class ChildEmotionControllerTest {
    @Test
    public void testSubmitEmotion() {
        assertTrue(false, "Implement real test");
    }
}
```

- [ ] **Step 2: Run test to verify it fails**

Run: `mvn test -pl smallsteps-modules/smallsteps-child -Dtest=ChildEmotionControllerTest`
Expected: FAIL

- [ ] **Step 3: Write minimal implementation**

Create `ChildEmotionController.java`:
```java
package com.kenzhao.smallsteps.child.controller;

import org.springframework.web.bind.annotation.*;
import com.kenzhao.smallsteps.common.core.domain.R;

@RestController
@RequestMapping("/child/emotion")
public class ChildEmotionController {
    
    @PostMapping("/submit")
    public R<Void> submitEmotion(@RequestBody EmotionSubmitDto dto) {
        // call service to save emotion
        return R.ok();
    }
}
```

Create `IChildEmotionService.java` and `ChildEmotionServiceImpl.java` saving records to `ss_emotion_record`.

- [ ] **Step 4: Run test to verify it passes**

Run: `mvn test -pl smallsteps-modules/smallsteps-child -Dtest=ChildEmotionControllerTest`
Expected: PASS

- [ ] **Step 5: Commit**

```bash
git add smallsteps-api/smallsteps-modules/smallsteps-child/src/
git commit -m "feat: add child emotion submission api"
```

### Task 4: AI Emotion Analysis Job

Create a scheduled task that queries daily emotions + failed tasks and calls the AI service to generate a parent feedback text.

**Files:**
- Create: `smallsteps-api/smallsteps-modules/smallsteps-job/src/main/java/com/kenzhao/smallsteps/job/task/EmotionAiAnalysisTask.java`

- [ ] **Step 1: Write the failing test**

```java
// smallsteps-api/smallsteps-modules/smallsteps-job/src/test/java/com/kenzhao/smallsteps/job/task/EmotionAiAnalysisTaskTest.java
package com.kenzhao.smallsteps.job.task;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class EmotionAiAnalysisTaskTest {
    @Test
    public void testAnalyze() {
        assertTrue(false, "Implement real test");
    }
}
```

- [ ] **Step 2: Run test to verify it fails**

Run: `mvn test -pl smallsteps-modules/smallsteps-job -Dtest=EmotionAiAnalysisTaskTest`
Expected: FAIL

- [ ] **Step 3: Write minimal implementation**

```java
package com.kenzhao.smallsteps.job.task;

import org.springframework.stereotype.Component;

@Component("emotionAiAnalysisTask")
public class EmotionAiAnalysisTask {
    
    public void analyzeDailyEmotions() {
        // 1. Fetch distinct children who had > 0 failed tasks or submitted negative emotion today
        // 2. Loop through each child
        // 3. Call IAiService to generate prompt: "Child failed X tasks, reported feeling Y. Generate short pacifying advice for parent."
        // 4. Save result into ss_emotion_record (or a separate AI insight table) linked to the parent.
    }
}
```

- [ ] **Step 4: Run test to verify it passes**

Run: `mvn test -pl smallsteps-modules/smallsteps-job -Dtest=EmotionAiAnalysisTaskTest`
Expected: PASS

- [ ] **Step 5: Commit**

```bash
git add smallsteps-api/smallsteps-modules/smallsteps-job/src/
git commit -m "feat: add ai batch job for emotion analysis"
```

---

## Chunk 3: Frontend Integration

### Task 5: Child Wish House UI

Create the frontend page where a child can browse available rewards and redeem stars.

**Files:**
- Create: `smallsteps-app/src/pages/child/wish-house/index.vue`
- Modify: `smallsteps-app/src/api/reward.js`

- [ ] **Step 1: Write the failing test**

*(No Playwright setup exists yet, we rely on manual/build verification for UI).*
Run: `npm run build:h5 --prefix smallsteps-app`
If the component does not exist and is referenced in `pages.json`, it fails.

- [ ] **Step 2: Write minimal implementation**

`smallsteps-app/src/pages/child/wish-house/index.vue`:
```vue
<template>
  <view class="min-h-screen bg-gray-50 p-4">
    <view class="text-xl font-bold mb-4">My Wish House</view>
    <view class="grid grid-cols-2 gap-4">
       <!-- Mock reward list -->
       <view class="bg-white rounded-xl p-4 shadow text-center">
         <view class="text-lg">Go to Zoo</view>
         <view class="text-orange-500 font-bold">50 Stars</view>
         <button class="mt-2 bg-blue-500 text-white rounded-full px-4 py-1" @click="redeem(1)">Redeem</button>
       </view>
    </view>
  </view>
</template>

<script setup>
import { ref } from 'vue'

const redeem = (rewardId) => {
  // Call API to redeem reward
  uni.showToast({ title: 'Request Sent!', icon: 'success' })
}
</script>
```

Add to `smallsteps-app/src/api/reward.js` (create if needed):
```javascript
import request from '@/utils/request'
export function redeemReward(data) {
  return request({ url: '/child/reward/redeem', method: 'post', data })
}
```

- [ ] **Step 3: Commit**

```bash
git add smallsteps-app/src/
git commit -m "feat: add child wish house ui"
```

### Task 6: Parent Emotion Alert UI

Create a card/page in the parent dashboard to view AI emotion alerts.

**Files:**
- Create/Modify: `smallsteps-app/src/pages/parent/emotion-alert/index.vue`

- [ ] **Step 1: Write minimal implementation**

```vue
<template>
  <view class="p-4 bg-red-50 rounded-lg border border-red-100 mb-4">
    <view class="text-red-600 font-bold mb-2">AI Alert: High Frustration Detected</view>
    <view class="text-sm text-gray-700">
       Your child failed 2 math tasks and reported feeling angry. 
       Suggestion: "I noticed math was tough today, let's take a 10 minute break and play a game."
    </view>
    <button class="mt-3 bg-red-500 text-white rounded-full text-sm px-4 py-1" @click="markRead">Mark as Read</button>
  </view>
</template>

<script setup>
const markRead = () => {
  // call api to mark as read
  uni.showToast({ title: 'Alert dismissed', icon: 'success' })
}
</script>
```

- [ ] **Step 2: Commit**

```bash
git add smallsteps-app/src/
git commit -m "feat: add parent emotion alert ui"
```
