package com.kenzhao.smallsteps.common.ss.domain.vo;

import lombok.Data;
import java.io.Serial;

@Data
public class InviteInfoVo implements Serial {

    @Serial
    private static final long serialVersionUID = 1L;

    private String inviteCode;

    private String familyName;

    private String creatorName;

    private String expiresAt;

    private Boolean isValid;
}