package com.kenzhao.smallsteps.parent.domain.bo;

import com.kenzhao.smallsteps.common.mybatis.core.domain.BaseEntity;
import com.kenzhao.smallsteps.common.core.validate.AddGroup;
import com.kenzhao.smallsteps.common.core.validate.EditGroup;
import jakarta.validation.constraints.*;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 亲子契约业务对象 parent_contract
 *
 * @author 赵轩
 * @date 2026-02-01
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class ParentContractBo extends BaseEntity {

    /**
     * 契约ID
     */
    @NotNull(message = "契约ID不能为空", groups = { EditGroup.class })
    private Long contractId;

    /**
     * 家长ID
     */
    @NotNull(message = "家长ID不能为空", groups = { AddGroup.class, EditGroup.class })
    private Long parentId;

    /**
     * 儿童ID
     */
    @NotNull(message = "儿童ID不能为空", groups = { AddGroup.class, EditGroup.class })
    private Long childId;

    /**
     * 契约内容
     */
    @NotBlank(message = "契约内容不能为空", groups = { AddGroup.class, EditGroup.class })
    private String content;

    /**
     * 签名图片
     */
    private String signatureImg;

    /**
     * 状态(0草稿 1生效 2终止)
     */
    private String status;

}
