package com.kenzhao.smallsteps.parent.domain.bo;

import com.kenzhao.smallsteps.common.core.validate.AddGroup;
import com.kenzhao.smallsteps.common.core.validate.EditGroup;
import com.kenzhao.smallsteps.parent.domain.ParentEmotionKit;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 情绪急救包配置业务对象
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class ParentEmotionKitBo extends ParentEmotionKit {

//    /**
//     * 新增时校验
//     */
//    public interface AddGroup extends AddGroup {
//    }
//
//    /**
//     * 修改时校验
//     */
//    public interface EditGroup extends EditGroup {
//    }

    @NotNull(message = "孩子ID不能为空", groups = {AddGroup.class, EditGroup.class})
    @Override
    public Long getChildId() {
        return super.getChildId();
    }

    @NotBlank(message = "急救包名称不能为空", groups = {AddGroup.class, EditGroup.class})
    @Override
    public String getKitName() {
        return super.getKitName();
    }

    @NotNull(message = "情绪类型不能为空", groups = {AddGroup.class, EditGroup.class})
    @Override
    public Integer getEmotionType() {
        return super.getEmotionType();
    }

    @NotBlank(message = "急救包内容不能为空", groups = {AddGroup.class, EditGroup.class})
    @Override
    public String getContent() {
        return super.getContent();
    }
}
