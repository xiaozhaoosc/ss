package com.kenzhao.smallsteps.common.ss.domain.dto;

import lombok.Data;
import java.io.Serial;

@Data
public class JoinRequestDTO implements Serial {

    @Serial
    private static final long serialVersionUID = 1L;

    private String inviteCode;
}