# 家庭邀请功能设计方案

**日期**: 2026-04-28
**状态**: 已批准

---

## 1. 概述

实现家庭邀请功能，允许家长通过分享链接或邀请码的方式邀请其他用户加入家庭，并支持审核机制。

---

## 2. 数据模型

### 2.1 家庭邀请表 (ss_family_invite)

| 字段 | 类型 | 说明 |
|------|------|------|
| invite_id | bigint | 邀请ID（主键） |
| dept_id | bigint | 家庭部门ID |
| invite_code | varchar(16) | 邀请码（唯一索引） |
| creator_id | bigint | 创建者ID |
| expires_at | timestamp | 过期时间 |
| max_uses | int | 最大使用次数（默认1） |
| used_count | int | 已使用次数 |
| status | char(1) | 状态（0有效 1失效） |
| del_flag | char(1) | 删除标志 |
| create_time | timestamp | 创建时间 |
| update_time | timestamp | 更新时间 |

### 2.2 加入申请表 (ss_family_join_request)

| 字段 | 类型 | 说明 |
|------|------|------|
| request_id | bigint | 申请ID（主键） |
| invite_code | varchar(16) | 邀请码 |
| applicant_id | bigint | 申请人ID |
| target_dept_id | bigint | 目标家庭ID |
| current_dept_id | bigint | 原家庭ID（用于禁用） |
| status | char(1) | 状态（0待审核 1已通过 2已拒绝） |
| del_flag | char(1) | 删除标志 |
| create_time | timestamp | 申请时间 |
| update_time | timestamp | 更新时间 |

---

## 3. API 设计

### 3.1 家长端 API

| 接口 | 方法 | 说明 |
|------|------|------|
| `/parent/family/invite/generate` | POST | 生成分享链接和邀请码 |
| `/parent/family/invite/validate` | GET | 验证邀请码有效性 |
| `/parent/family/join-requests` | GET | 获取待审核的加入申请列表 |
| `/parent/family/join-request/{id}/approve` | POST | 批准加入申请 |
| `/parent/family/join-request/{id}/reject` | POST | 拒绝加入申请 |

### 3.2 用户端 API

| 接口 | 方法 | 说明 |
|------|------|------|
| `/family/invite/info` | GET | 获取邀请信息（家庭名称等） |
| `/family/join-request` | POST | 提交加入申请 |

---

## 4. 业务流程

### 4.1 家长端流程

```
1. 进入「家庭管理」→ 点击「邀请成员」
2. 系统生成分享链接（如 smallsteps://join?code=ABC123）
3. 分享给需要加入的人
4. 在「待审核列表」查看申请
5. 审核通过/拒绝
```

### 4.2 用户端流程

```
1. 点击分享链接 → APP打开并解析邀请码
2. 查看邀请信息（家庭名称、创建者等）
3. 点击「申请加入」→ 系统提交加入申请
4. 等待家长审核
5. 审核通过后自动加入新家庭，原家庭被禁用
```

---

## 5. 核心逻辑

### 5.1 生成邀请码

```java
public InviteGenerateVO generateInviteCode(Long deptId, Long creatorId) {
    // 1. 生成6位唯一邀请码
    String inviteCode = generateUniqueCode();
    // 2. 写入数据库
    SsFamilyInvite invite = new SsFamilyInvite();
    invite.setDeptId(deptId);
    invite.setInviteCode(inviteCode);
    invite.setCreatorId(creatorId);
    invite.setExpiresAt(LocalDateTime.now().plusDays(7)); // 7天过期
    invite.setMaxUses(1);
    invite.setUsedCount(0);
    invite.setStatus("0");
    // 3. 返回分享链接
    String shareUrl = "smallsteps://join?code=" + inviteCode;
    return new InviteGenerateVO(inviteCode, shareUrl);
}
```

### 5.2 审核通过

```java
public void approveJoinRequest(Long requestId) {
    // 1. 获取申请信息
    SsFamilyJoinRequest request = getById(requestId);
    // 2. 修改申请状态为「已通过」
    request.setStatus("1");
    // 3. 将申请人的 dept_id 更新为新家庭
    userService.updateUserDept(request.getApplicantId(), request.getTargetDeptId());
    // 4. 将原部门禁用
    deptService.disableDept(request.getCurrentDeptId());
    // 5. 删除邀请码记录
    inviteMapper.deleteByCode(request.getInviteCode());
}
```

---

## 6. 错误处理

| 场景 | 处理方式 |
|------|----------|
| 邀请码已过期 | 提示"邀请码已过期" |
| 邀请码已达最大使用次数 | 提示"邀请码已失效" |
| 用户已在该家庭中 | 提示"您已在该家庭中" |
| 原家庭禁用失败 | 记录日志，继续处理 |

---

## 7. 实现任务

### 7.1 数据库

- [ ] 创建 ss_family_invite 表
- [ ] 创建 ss_family_join_request 表

### 7.2 后端

- [ ] 创建实体类 SsFamilyInvite
- [ ] 创建实体类 SsFamilyJoinRequest
- [ ] 创建 Mapper 接口
- [ ] 创建 Service 接口和实现
- [ ] 创建 Controller
- [ ] 实现邀请码生成逻辑
- [ ] 实现加入申请逻辑
- [ ] 实现审核通过/拒绝逻辑

### 7.3 前端 APP

- [ ] 创建邀请成员页面
- [ ] 创建申请加入页面
- [ ] 创建待审核列表页面
- [ ] 实现 Deep Link 解析
- [ ] 实现分享功能

---

## 8. 测试用例

1. 家长生成分享链接和邀请码
2. 用户通过链接申请加入
3. 家长审核通过，用户加入新家庭，原家庭被禁用
4. 家长审核拒绝，用户收到拒绝通知
5. 邀请码过期测试
6. 邀请码已达最大使用次数测试
7. 用户已在该家庭中的测试
