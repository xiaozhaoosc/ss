package com.kenzhao.smallsteps.common.ss.domain;

import com.baomidou.mybatisplus.annotation.*;
import com.kenzhao.smallsteps.common.mybatis.core.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serial;

/**
 * 亲子契约对象 parent_contract
 *
 * @author 赵轩
 * @date 2026-02-01
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("ss_parent_contract")
public class ParentContract extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    @TableId(value = "contract_id")
    private Long contractId;

    private Long parentId;
    private Long childId;
    private String content;
    private String signatureImg;
    private String status;

    @TableLogic
    private String delFlag;
}
