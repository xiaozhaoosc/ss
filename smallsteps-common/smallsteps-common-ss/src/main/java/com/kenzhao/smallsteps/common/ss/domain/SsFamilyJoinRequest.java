package com.kenzhao.smallsteps.common.ss.domain;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;
import java.io.Serial;
import java.time.LocalDateTime;

@Data
@TableName("ss_family_join_request")
public class SsFamilyJoinRequest {

    @Serial
    private static final long serialVersionUID = 1L;

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