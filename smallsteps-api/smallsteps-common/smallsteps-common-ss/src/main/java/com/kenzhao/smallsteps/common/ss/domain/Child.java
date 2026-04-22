package com.kenzhao.smallsteps.common.ss.domain;

import com.baomidou.mybatisplus.annotation.*;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.kenzhao.smallsteps.common.mybatis.core.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serial;
import java.util.Date;

/**
 * 儿童信息对象 ss_child
 *
 * @author 赵轩
 * @date 2026-04-14
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("ss_child")
public class Child extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * ID
     */
    @TableId(value = "id")
    private Long id;

    /**
     * 关联家长用户ID (sys_user.user_id)
     */
    private Long parentId;

    /**
     * 昵称
     */
    private String nickname;

    /**
     * 出生日期
     */
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date birthday;

    /**
     * 性别 (0男 1女 2未知)
     */
    private String gender;

    /**
     * 头像地址
     */
    private String avatarUrl;

    /**
     * 当前星数余额
     */
    private Integer starBalance;

    /**
     * 累计获得星数
     */
    private Integer totalStars;

    /**
     * 等级
     */
    private Integer level;

    /**
     * 删除标志 (0代表存在 2代表删除)
     */
    @TableLogic
    private String delFlag;

}
