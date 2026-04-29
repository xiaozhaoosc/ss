package com.kenzhao.smallsteps.common.ss.domain;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.time.LocalDateTime;

/**
 * 家庭邀请表
 */
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
