package com.kenzhao.smallsteps.common.ss.domain;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.io.Serial;
import java.time.LocalDateTime;

@Data
@TableName("ss_family_invite")
public class SsFamilyInvite {

    @Serial
    private static final long serialVersionUID = 1L;

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