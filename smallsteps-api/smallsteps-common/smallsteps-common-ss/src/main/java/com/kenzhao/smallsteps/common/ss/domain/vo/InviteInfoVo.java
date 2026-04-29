package com.kenzhao.smallsteps.common.ss.domain.vo;

import lombok.Data;

/**
 * 邀请信息视图对象
 */
@Data
public class InviteInfoVo {
    private String inviteCode;
    private String familyName;
    private String creatorName;
    private String expiresAt;
    private Boolean isValid;
}
