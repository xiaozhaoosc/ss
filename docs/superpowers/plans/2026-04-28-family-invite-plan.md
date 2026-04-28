# 家庭邀请功能实现计划

> **面向 AI 代理的工作者：** 必需子技能：使用 superpowers:subagent-driven-development（推荐）或 superpowers:executing-plans 逐任务实现此计划。步骤使用复选框（`- [ ]`）语法来跟踪进度。

**目标：** 实现家庭邀请功能，支持家长生成分享链接/邀请码，其他用户通过链接申请加入，审核通过后加入新家庭且原家庭被禁用。

**架构：** 使用部门（sys_dept）作为家庭概念，通过独立的邀请表和申请表管理邀请流程。

**技术栈：** Java Spring Boot + MyBatis-Plus + UniApp Vue3

---

## 文件结构

### 数据库
- 创建：`smallsteps-api/script/sql/update/add_family_invite_tables.sql`

### 后端实体类
- 创建：`smallsteps-common/smallsteps-common-ss/src/main/java/com/kenzhao/smallsteps/common/ss/domain/SsFamilyInvite.java`
- 创建：`smallsteps-common/smallsteps-common-ss/src/main/java/com/kenzhao/smallsteps/common/ss/domain/SsFamilyJoinRequest.java`
- 创建：`smallsteps-common/smallsteps-common-ss/src/main/java/com/kenzhao/smallsteps/common/ss/domain/vo/InviteInfoVo.java`
- 创建：`smallsteps-common/smallsteps-common-ss/src/main/java/com/kenzhao/smallsteps/common/ss/domain/dto/JoinRequestDTO.java`

### 后端Mapper
- 创建：`smallsteps-parent/src/main/java/com/kenzhao/smallsteps/parent/mapper/FamilyInviteMapper.java`
- 创建：`smallsteps-parent/src/main/java/com/kenzhao/smallsteps/parent/mapper/FamilyJoinRequestMapper.java`

### 后端Service
- 创建：`smallsteps-parent/src/main/java/com/kenzhao/smallsteps/parent/service/IFamilyInviteService.java`
- 创建：`smallsteps-parent/src/main/java/com/kenzhao/smallsteps/parent/service/impl/FamilyInviteServiceImpl.java`
- 修改：`smallsteps-parent/src/main/java/com/kenzhao/smallsteps/parent/service/IParentChildService.java`
- 修改：`smallsteps-parent/src/main/java/com/kenzhao/smallsteps/parent/service/impl/ParentChildServiceImpl.java`

### 后端Controller
- 创建：`smallsteps-parent/src/main/java/com/kenzhao/smallsteps/parent/controller/FamilyInviteController.java`
- 创建：`smallsteps-parent/src/main/java/com/kenzhao/smallsteps/parent/controller/JoinRequestController.java`

### 前端API
- 创建：`smallsteps-app/src/api/family-invite.ts`

### 前端页面
- 创建：`smallsteps-app/src/pages/family/invite/index.vue` - 邀请信息展示页
- 创建：`smallsteps-app/src/pages/family/invite/apply.vue` - 申请加入页
- 修改：`smallsteps-app/src/pages/parent/profile/index.vue` - 添加邀请入口
- 修改：`smallsteps-app/src/pages.json` - 添加路由

### 自动化测试
- 创建：`smallsteps-app/tests/e2e/spec/family-invite.spec.ts`

---

## 任务列表

### 任务 1：创建数据库表

**文件：**
- 创建：`smallsteps-api/script/sql/update/add_family_invite_tables.sql`

- [ ] **步骤 1：编写数据库建表SQL**

```sql
-- 家庭邀请表
CREATE TABLE IF NOT EXISTS ss_family_invite (
    invite_id          BIGINT          NOT NULL AUTO_INCREMENT PRIMARY KEY,
    dept_id            BIGINT          NOT NULL COMMENT '家庭部门ID',
    invite_code        VARCHAR(16)     NOT NULL UNIQUE COMMENT '邀请码',
    creator_id         BIGINT          NOT NULL COMMENT '创建者ID',
    expires_at         TIMESTAMP       NOT NULL COMMENT '过期时间',
    max_uses           INT             DEFAULT 1 COMMENT '最大使用次数',
    used_count         INT             DEFAULT 0 COMMENT '已使用次数',
    status             CHAR(1)         DEFAULT '0' COMMENT '状态(0有效 1失效)',
    del_flag           CHAR(1)         DEFAULT '0' COMMENT '删除标志',
    create_time        TIMESTAMP       DEFAULT CURRENT_TIMESTAMP,
    update_time        TIMESTAMP       DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_invite_code (invite_code),
    INDEX idx_dept_id (dept_id)
) COMMENT '家庭邀请表';

-- 家庭加入申请表
CREATE TABLE IF NOT EXISTS ss_family_join_request (
    request_id         BIGINT          NOT NULL AUTO_INCREMENT PRIMARY KEY,
    invite_code        VARCHAR(16)     NOT NULL COMMENT '邀请码',
    applicant_id       BIGINT          NOT NULL COMMENT '申请人ID',
    target_dept_id     BIGINT          NOT NULL COMMENT '目标家庭ID',
    current_dept_id    BIGINT          COMMENT '原家庭ID',
    status             CHAR(1)         DEFAULT '0' COMMENT '状态(0待审核 1已通过 2已拒绝)',
    del_flag           CHAR(1)         DEFAULT '0' COMMENT '删除标志',
    create_time        TIMESTAMP       DEFAULT CURRENT_TIMESTAMP,
    update_time        TIMESTAMP       DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_applicant_id (applicant_id),
    INDEX idx_status (status)
) COMMENT '家庭加入申请表';
```

- [ ] **步骤 2：执行SQL创建表**

执行：`psql -h 10.8.0.1 -p 15432 -U smallsteps -d smallsteps_db -f add_family_invite_tables.sql`

---

### 任务 2：创建后端实体类

**文件：**
- 创建：`smallsteps-common/smallsteps-common-ss/src/main/java/com/kenzhao/smallsteps/common/ss/domain/SsFamilyInvite.java`
- 创建：`smallsteps-common/smallsteps-common-ss/src/main/java/com/kenzhao/smallsteps/common/ss/domain/SsFamilyJoinRequest.java`
- 创建：`smallsteps-common/smallsteps-common-ss/src/main/java/com/kenzhao/smallsteps/common/ss/domain/vo/InviteInfoVo.java`
- 创建：`smallsteps-common/smallsteps-common-ss/src/main/java/com/kenzhao/smallsteps/common/ss/domain/dto/JoinRequestDTO.java`

- [ ] **步骤 1：创建 SsFamilyInvite 实体类**

```java
package com.kenzhao.smallsteps.common.ss.domain;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@TableName("ss_family_invite")
public class SsFamilyInvite {

    @TableId(value = "invite_id")
    private Long inviteId;

    private Long deptId;
    private String inviteCode;
    private Long creatorId;
    private LocalDateTime expiresAt;
    private Integer maxUses;
    private Integer usedCount;
    private String status;

    @TableLogic
    private String delFlag;

    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}
```

- [ ] **步骤 2：创建 SsFamilyJoinRequest 实体类**

```java
package com.kenzhao.smallsteps.common.ss.domain;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@TableName("ss_family_join_request")
public class SsFamilyJoinRequest {

    @TableId(value = "request_id")
    private Long requestId;

    private String inviteCode;
    private Long applicantId;
    private Long targetDeptId;
    private Long currentDeptId;
    private String status;

    @TableLogic
    private String delFlag;

    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}
```

- [ ] **步骤 3：创建 InviteInfoVo 视图类**

```java
package com.kenzhao.smallsteps.common.ss.domain.vo;

import lombok.Data;

@Data
public class InviteInfoVo {
    private String inviteCode;
    private String familyName;
    private String creatorName;
    private String expiresAt;
    private Boolean isValid;
}
```

- [ ] **步骤 4：创建 JoinRequestDTO 类**

```java
package com.kenzhao.smallsteps.common.ss.domain.dto;

import lombok.Data;

@Data
public class JoinRequestDTO {
    private String inviteCode;
}
```

---

### 任务 3：创建后端Mapper接口

**文件：**
- 创建：`smallsteps-parent/src/main/java/com/kenzhao/smallsteps/parent/mapper/FamilyInviteMapper.java`
- 创建：`smallsteps-parent/src/main/java/com/kenzhao/smallsteps/parent/mapper/FamilyJoinRequestMapper.java`

- [ ] **步骤 1：创建 FamilyInviteMapper**

```java
package com.kenzhao.smallsteps.parent.mapper;

import com.kenzhao.smallsteps.common.mybatis.core.mapper.BaseMapperPlus;
import com.kenzhao.smallsteps.common.ss.domain.SsFamilyInvite;
import org.apache.ibatis.annotations.Param;

public interface FamilyInviteMapper extends BaseMapperPlus<SsFamilyInvite, SsFamilyInvite> {

    SsFamilyInvite selectByInviteCode(@Param("inviteCode") String inviteCode);
}
```

- [ ] **步骤 2：创建 FamilyJoinRequestMapper**

```java
package com.kenzhao.smallsteps.parent.mapper;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.kenzhao.smallsteps.common.mybatis.core.mapper.BaseMapperPlus;
import com.kenzhao.smallsteps.common.ss.domain.SsFamilyJoinRequest;
import java.util.List;

public interface FamilyJoinRequestMapper extends BaseMapperPlus<SsFamilyJoinRequest, SsFamilyJoinRequest> {

    default List<SsFamilyJoinRequest> selectPendingByDeptId(Long deptId) {
        return this.selectList(new LambdaQueryWrapper<SsFamilyJoinRequest>()
            .eq(SsFamilyJoinRequest::getStatus, "0")
            .orderByDesc(SsFamilyJoinRequest::getCreateTime));
    }

    default List<SsFamilyJoinRequest> selectPendingByCreatorId(Long creatorId) {
        return this.selectList(new LambdaQueryWrapper<SsFamilyJoinRequest>()
            .eq(SsFamilyJoinRequest::getStatus, "0")
            .orderByDesc(SsFamilyJoinRequest::getCreateTime));
    }
}
```

---

### 任务 4：创建后端Service层

**文件：**
- 创建：`smallsteps-parent/src/main/java/com/kenzhao/smallsteps/parent/service/IFamilyInviteService.java`
- 创建：`smallsteps-parent/src/main/java/com/kenzhao/smallsteps/parent/service/impl/FamilyInviteServiceImpl.java`

- [ ] **步骤 1：创建 IFamilyInviteService 接口**

```java
package com.kenzhao.smallsteps.parent.service;

import com.kenzhao.smallsteps.common.ss.domain.SsFamilyInvite;
import com.kenzhao.smallsteps.common.ss.domain.SsFamilyJoinRequest;
import com.kenzhao.smallsteps.common.ss.domain.dto.JoinRequestDTO;
import com.kenzhao.smallsteps.common.ss.domain.vo.InviteInfoVo;
import java.util.List;

public interface IFamilyInviteService {

    InviteInfoVo generateInviteCode(Long deptId, Long creatorId);

    InviteInfoVo validateInviteCode(String inviteCode);

    InviteInfoVo getInviteInfo(String inviteCode);

    void submitJoinRequest(JoinRequestDTO dto, Long applicantId);

    List<SsFamilyJoinRequest> getPendingRequests(Long deptId);

    void approveRequest(Long requestId);

    void rejectRequest(Long requestId);

    List<SsFamilyJoinRequest> getMyRequests(Long applicantId);
}
```

- [ ] **步骤 2：创建 FamilyInviteServiceImpl 实现类**

```java
package com.kenzhao.smallsteps.parent.service.impl;

import cn.hutool.core.util.IdUtil;
import com.kenzhao.smallsteps.common.ss.domain.SsFamilyInvite;
import com.kenzhao.smallsteps.common.ss.domain.SsFamilyJoinRequest;
import com.kenzhao.smallsteps.common.ss.domain.dto.JoinRequestDTO;
import com.kenzhao.smallsteps.common.ss.domain.vo.InviteInfoVo;
import com.kenzhao.smallsteps.parent.mapper.FamilyInviteMapper;
import com.kenzhao.smallsteps.parent.mapper.FamilyJoinRequestMapper;
import com.kenzhao.smallsteps.system.domain.SysDept;
import com.kenzhao.smallsteps.system.domain.SysUser;
import com.kenzhao.smallsteps.system.mapper.SysDeptMapper;
import com.kenzhao.smallsteps.system.mapper.SysUserMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
public class FamilyInviteServiceImpl implements IFamilyInviteService {

    private final FamilyInviteMapper inviteMapper;
    private final FamilyJoinRequestMapper requestMapper;
    private final SysDeptMapper deptMapper;
    private final SysUserMapper userMapper;

    @Override
    public InviteInfoVo generateInviteCode(Long deptId, Long creatorId) {
        String inviteCode = generateUniqueCode();

        SsFamilyInvite invite = new SsFamilyInvite();
        invite.setDeptId(deptId);
        invite.setInviteCode(inviteCode);
        invite.setCreatorId(creatorId);
        invite.setExpiresAt(LocalDateTime.now().plusDays(7));
        invite.setMaxUses(1);
        invite.setUsedCount(0);
        invite.setStatus("0");
        invite.setDelFlag("0");
        inviteMapper.insert(invite);

        InviteInfoVo vo = new InviteInfoVo();
        vo.setInviteCode(inviteCode);
        vo.setIsValid(true);
        return vo;
    }

    @Override
    public InviteInfoVo validateInviteCode(String inviteCode) {
        SsFamilyInvite invite = inviteMapper.selectByInviteCode(inviteCode);
        InviteInfoVo vo = new InviteInfoVo();
        vo.setInviteCode(inviteCode);

        if (invite == null || !"0".equals(invite.getStatus())) {
            vo.setIsValid(false);
            return vo;
        }
        if (invite.getExpiresAt().isBefore(LocalDateTime.now())) {
            vo.setIsValid(false);
            return vo;
        }
        if (invite.getUsedCount() >= invite.getMaxUses()) {
            vo.setIsValid(false);
            return vo;
        }

        SysDept dept = deptMapper.selectById(invite.getDeptId());
        SysUser creator = userMapper.selectUserById(invite.getCreatorId());

        vo.setIsValid(true);
        vo.setFamilyName(dept != null ? dept.getDeptName() : "未知家庭");
        vo.setCreatorName(creator != null ? creator.getNickName() : "未知");
        vo.setExpiresAt(invite.getExpiresAt().toString());
        return vo;
    }

    @Override
    public InviteInfoVo getInviteInfo(String inviteCode) {
        return validateInviteCode(inviteCode);
    }

    @Override
    @Transactional
    public void submitJoinRequest(JoinRequestDTO dto, Long applicantId) {
        InviteInfoVo inviteInfo = validateInviteCode(dto.getInviteCode());
        if (!inviteInfo.getIsValid()) {
            throw new RuntimeException("邀请码无效或已过期");
        }

        SysUser applicant = userMapper.selectUserById(applicantId);

        SsFamilyJoinRequest request = new SsFamilyJoinRequest();
        request.setInviteCode(dto.getInviteCode());
        request.setApplicantId(applicantId);
        request.setTargetDeptId(inviteMapper.selectByInviteCode(dto.getInviteCode()).getDeptId());
        request.setCurrentDeptId(applicant.getDeptId());
        request.setStatus("0");
        request.setDelFlag("0");
        requestMapper.insert(request);
    }

    @Override
    public List<SsFamilyJoinRequest> getPendingRequests(Long deptId) {
        return requestMapper.selectPendingByDeptId(deptId);
    }

    @Override
    @Transactional
    public void approveRequest(Long requestId) {
        SsFamilyJoinRequest request = requestMapper.selectById(requestId);
        if (request == null) {
            throw new RuntimeException("申请不存在");
        }

        request.setStatus("1");
        requestMapper.updateById(request);

        SysUser applicant = userMapper.selectUserById(request.getApplicantId());
        applicant.setDeptId(request.getTargetDeptId());
        userMapper.updateById(applicant);

        if (request.getCurrentDeptId() != null) {
            SysDept oldDept = deptMapper.selectById(request.getCurrentDeptId());
            if (oldDept != null) {
                oldDept.setStatus("1");
                deptMapper.updateById(oldDept);
            }
        }

        SsFamilyInvite invite = inviteMapper.selectByInviteCode(request.getInviteCode());
        if (invite != null) {
            invite.setUsedCount(invite.getUsedCount() + 1);
            if (invite.getUsedCount() >= invite.getMaxUses()) {
                invite.setStatus("1");
            }
            inviteMapper.updateById(invite);
        }
    }

    @Override
    public void rejectRequest(Long requestId) {
        SsFamilyJoinRequest request = requestMapper.selectById(requestId);
        if (request == null) {
            throw new RuntimeException("申请不存在");
        }
        request.setStatus("2");
        requestMapper.updateById(request);
    }

    @Override
    public List<SsFamilyJoinRequest> getMyRequests(Long applicantId) {
        return requestMapper.selectList(
            new com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<SsFamilyJoinRequest>()
                .eq(SsFamilyJoinRequest::getApplicantId, applicantId)
                .orderByDesc(SsFamilyJoinRequest::getCreateTime)
        );
    }

    private String generateUniqueCode() {
        return IdUtil.simpleUUID().substring(0, 8).toUpperCase();
    }
}
```

---

### 任务 5：创建后端Controller

**文件：**
- 创建：`smallsteps-parent/src/main/java/com/kenzhao/smallsteps/parent/controller/FamilyInviteController.java`
- 创建：`smallsteps-parent/src/main/java/com/kenzhao/smallsteps/parent/controller/JoinRequestController.java`

- [ ] **步骤 1：创建 FamilyInviteController**

```java
package com.kenzhao.smallsteps.parent.controller;

import com.kenzhao.smallsteps.common.core.domain.R;
import com.kenzhao.smallsteps.common.core.helper.LoginHelper;
import com.kenzhao.smallsteps.common.ss.domain.SsFamilyJoinRequest;
import com.kenzhao.smallsteps.common.ss.domain.vo.InviteInfoVo;
import com.kenzhao.smallsteps.parent.service.IFamilyInviteService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@Tag(name = "家庭邀请", description = "家庭邀请相关接口")
@RequiredArgsConstructor
@RestController
@RequestMapping("/parent/family/invite")
public class FamilyInviteController {

    private final IFamilyInviteService familyInviteService;

    @Operation(summary = "生成分享链接和邀请码")
    @PostMapping("/generate")
    public R<InviteInfoVo> generate() {
        Long userId = LoginHelper.getUserId();
        Long deptId = LoginHelper.getDeptId();
        return R.ok(familyInviteService.generateInviteCode(deptId, userId));
    }

    @Operation(summary = "验证邀请码")
    @GetMapping("/validate")
    public R<InviteInfoVo> validate(@RequestParam String code) {
        return R.ok(familyInviteService.validateInviteCode(code));
    }

    @Operation(summary = "获取待审核的加入申请列表")
    @GetMapping("/requests")
    public R<List<SsFamilyJoinRequest>> getPendingRequests() {
        Long deptId = LoginHelper.getDeptId();
        return R.ok(familyInviteService.getPendingRequests(deptId));
    }

    @Operation(summary = "批准加入申请")
    @PostMapping("/request/{id}/approve")
    public R<Void> approve(@PathVariable Long id) {
        familyInviteService.approveRequest(id);
        return R.ok();
    }

    @Operation(summary = "拒绝加入申请")
    @PostMapping("/request/{id}/reject")
    public R<Void> reject(@PathVariable Long id) {
        familyInviteService.rejectRequest(id);
        return R.ok();
    }
}
```

- [ ] **步骤 2：创建 JoinRequestController**

```java
package com.kenzhao.smallsteps.parent.controller;

import com.kenzhao.smallsteps.common.core.domain.R;
import com.kenzhao.smallsteps.common.core.helper.LoginHelper;
import com.kenzhao.smallsteps.common.ss.domain.SsFamilyJoinRequest;
import com.kenzhao.smallsteps.common.ss.domain.dto.JoinRequestDTO;
import com.kenzhao.smallsteps.common.ss.domain.vo.InviteInfoVo;
import com.kenzhao.smallsteps.parent.service.IFamilyInviteService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@Tag(name = "加入申请", description = "加入申请相关接口")
@RequiredArgsConstructor
@RestController
@RequestMapping("/family")
public class JoinRequestController {

    private final IFamilyInviteService familyInviteService;

    @Operation(summary = "获取邀请信息")
    @GetMapping("/invite/info")
    public R<InviteInfoVo> getInviteInfo(@RequestParam String code) {
        return R.ok(familyInviteService.getInviteInfo(code));
    }

    @Operation(summary = "提交加入申请")
    @PostMapping("/join-request")
    public R<Void> submitJoinRequest(@RequestBody JoinRequestDTO dto) {
        Long userId = LoginHelper.getUserId();
        familyInviteService.submitJoinRequest(dto, userId);
        return R.ok();
    }

    @Operation(summary = "获取我的申请列表")
    @GetMapping("/my-requests")
    public R<List<SsFamilyJoinRequest>> getMyRequests() {
        Long userId = LoginHelper.getUserId();
        return R.ok(familyInviteService.getMyRequests(userId));
    }
}
```

---

### 任务 6：创建前端API

**文件：**
- 创建：`smallsteps-app/src/api/family-invite.ts`

- [ ] **步骤 1：创建 family-invite.ts**

```typescript
import request from '@/utils/request'

export function generateInviteCode() {
  return request({
    url: '/parent/family/invite/generate',
    method: 'post'
  })
}

export function validateInviteCode(code: string) {
  return request({
    url: '/parent/family/invite/validate',
    method: 'get',
    params: { code }
  })
}

export function getInviteInfo(code: string) {
  return request({
    url: '/family/invite/info',
    method: 'get',
    params: { code }
  })
}

export function submitJoinRequest(data: { inviteCode: string }) {
  return request({
    url: '/family/join-request',
    method: 'post',
    data
  })
}

export function getPendingRequests() {
  return request({
    url: '/parent/family/invite/requests',
    method: 'get'
  })
}

export function approveRequest(id: number) {
  return request({
    url: `/parent/family/invite/request/${id}/approve`,
    method: 'post'
  })
}

export function rejectRequest(id: number) {
  return request({
    url: `/parent/family/invite/request/${id}/reject`,
    method: 'post'
  })
}

export function getMyRequests() {
  return request({
    url: '/family/my-requests',
    method: 'get'
  })
}
```

---

### 任务 7：创建前端页面

**文件：**
- 创建：`smallsteps-app/src/pages/family/invite/index.vue`
- 创建：`smallsteps-app/src/pages/family/invite/apply.vue`
- 修改：`smallsteps-app/src/pages/parent/profile/index.vue`
- 修改：`smallsteps-app/src/pages.json`

- [ ] **步骤 1：创建邀请信息展示页 index.vue**

```vue
<template>
  <view class="invite-page">
    <top-bar title="邀请加入家庭" back-btn />

    <view class="content" v-if="loading">
      <loading />
    </view>

    <view class="content" v-else-if="inviteInfo && inviteInfo.isValid">
      <view class="family-card">
        <text class="family-name">{{ inviteInfo.familyName }}</text>
        <text class="creator-name">创建者：{{ inviteInfo.creatorName }}</text>
        <text class="expires">有效期至：{{ inviteInfo.expiresAt }}</text>
      </view>

      <button class="apply-btn" @click="goToApply">申请加入</button>
    </view>

    <view class="content invalid" v-else>
      <text class="invalid-text">邀请码无效或已过期</text>
      <button class="back-btn" @click="goBack">返回</button>
    </view>
  </view>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import TopBar from '@/components/common/top-bar/top-bar.vue'
import Loading from '@/components/common/loading/loading.vue'
import { getInviteInfo } from '@/api/family-invite'

const inviteInfo = ref(null)
const loading = ref(true)

onMounted(async () => {
  const code = getInviteCodeFromUrl()
  if (code) {
    try {
      const res = await getInviteInfo(code)
      inviteInfo.value = res.data
    } catch (e) {
      console.error(e)
    }
  }
  loading.value = false
})

function getInviteCodeFromUrl() {
  const pages = getCurrentPages()
  const currentPage = pages[pages.length - 1]
  const options = currentPage.options || {}
  return options.code || ''
}

function goToApply() {
  uni.navigateTo({
    url: `/pages/family/invite/apply?code=${inviteInfo.value.inviteCode}`
  })
}

function goBack() {
  uni.navigateBack()
}
</script>
```

- [ ] **步骤 2：创建申请加入页 apply.vue**

```vue
<template>
  <view class="apply-page">
    <top-bar title="申请加入家庭" back-btn />

    <view class="content">
      <view class="family-card">
        <text class="family-name">{{ inviteInfo.familyName }}</text>
        <text class="creator-name">创建者：{{ inviteInfo.creatorName }}</text>
      </view>

      <view class="warning">
        <text>申请提交后，家庭管理员会收到通知进行审核。</text>
        <text>审核通过后，您将自动加入该家庭，原家庭将被禁用。</text>
      </view>

      <button class="submit-btn" :loading="submitting" @click="handleSubmit">
        确认申请
      </button>
    </view>
  </view>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import TopBar from '@/components/common/top-bar/top-bar.vue'
import { getInviteInfo, submitJoinRequest } from '@/api/family-invite'

const inviteInfo = ref(null)
const submitting = ref(false)

onMounted(async () => {
  const code = getInviteCodeFromUrl()
  if (code) {
    try {
      const res = await getInviteInfo(code)
      inviteInfo.value = res.data
    } catch (e) {
      console.error(e)
    }
  }
})

function getInviteCodeFromUrl() {
  const pages = getCurrentPages()
  const currentPage = pages[pages.length - 1]
  const options = currentPage.options || {}
  return options.code || ''
}

async function handleSubmit() {
  if (submitting.value) return
  submitting.value = true
  try {
    await submitJoinRequest({ inviteCode: inviteInfo.value.inviteCode })
    uni.showToast({ title: '申请已提交', icon: 'success' })
    setTimeout(() => {
      uni.switchTab({ url: '/pages/index/index' })
    }, 1500)
  } catch (e) {
    uni.showToast({ title: e.message || '提交失败', icon: 'none' })
  } finally {
    submitting.value = false
  }
}
</script>
```

- [ ] **步骤 3：在 profile/index.vue 添加邀请入口**

在"添加孩子"按钮旁边添加"邀请成员"按钮

- [ ] **步骤 4：在 pages.json 添加路由**

```json
{
  "path": "pages/family/invite/index",
  "style": { "navigationBarTitleText": "邀请加入家庭" }
},
{
  "path": "pages/family/invite/apply",
  "style": { "navigationBarTitleText": "申请加入家庭" }
}
```

---

### 任务 8：创建自动化测试

**文件：**
- 创建：`smallsteps-app/tests/e2e/spec/family-invite.spec.ts`

- [ ] **步骤 1：创建测试脚本**

```typescript
import { test, expect } from '@playwright/test';
import { TEST_ACCOUNTS } from '../../fixtures/test-data';
import { LoginPage } from '../pages/LoginPage';
import { ParentDashboardPage } from '../pages/ParentDashboardPage';
import { ParentNavPage } from '../pages/ParentNavPage';

test.describe('家庭邀请功能', () => {
  let loginPage: LoginPage;
  let dashboardPage: ParentDashboardPage;
  let navPage: ParentNavPage;

  test.beforeEach(async ({ page }) => {
    loginPage = new LoginPage(page);
    dashboardPage = new ParentDashboardPage(page);
    navPage = new ParentNavPage(page);

    await loginPage.goto();
    await loginPage.login(TEST_ACCOUNTS.parent1.username, TEST_ACCOUNTS.parent1.password);
    await dashboardPage.waitForReady();
  });

  test('家长生成分享链接', async ({ page }) => {
    await navPage.goToProfile();
    await page.waitForURL(/profile/);

    // 点击邀请成员按钮
    await page.click('.invite-btn');

    // 验证跳转到邀请页面
    await expect(page).toHaveURL(/invite/);

    // 验证分享链接生成
    const shareLink = await page.locator('.share-link').textContent();
    expect(shareLink).toContain('smallsteps://join?code=');
  });

  test('用户通过邀请码申请加入', async ({ page }) => {
    // 先用家长账号生成邀请码
    await navPage.goToProfile();
    await page.waitForURL(/profile/);
    await page.click('.invite-btn');
    const shareLink = await page.locator('.share-link').textContent();
    const inviteCode = shareLink.split('code=')[1];

    // 退出登录
    await navPage.goToHome();

    // 用另一个账号登录
    await loginPage.goto();
    await loginPage.login(TEST_ACCOUNTS.parent2.username, TEST_ACCOUNTS.parent2.password);
    await dashboardPage.waitForReady();

    // 访问邀请链接
    await page.goto(`/pages/family/invite/index?code=${inviteCode}`);
    await page.waitForLoadState('domcontentloaded');

    // 验证邀请信息显示
    const familyCard = page.locator('.family-card');
    await expect(familyCard).toBeVisible();

    // 点击申请加入
    await page.click('.apply-btn');
    await page.waitForURL(/apply/);

    // 确认申请
    await page.click('.submit-btn');

    // 验证申请成功提示
    await expect(page.locator('.uni-toast')).toContainText('申请已提交');
  });
});
```

---

## 执行方式

**计划已完成并保存到 `docs/superpowers/plans/2026-04-28-family-invite-plan.md`。两种执行方式：**

**1. 子代理驱动（推荐）** - 每个任务调度一个新的子代理，任务间进行审查，快速迭代

**2. 内联执行** - 在当前会话中使用 executing-plans 执行任务，批量执行并设有检查点

**选哪种方式？**