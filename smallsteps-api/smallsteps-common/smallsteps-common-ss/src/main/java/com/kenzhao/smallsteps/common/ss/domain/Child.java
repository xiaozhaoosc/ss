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
     * 儿童ID
     */
    @TableId(value = "child_id", type = IdType.AUTO)
    private Long childId;

    /**
     * 家庭ID (对应 sys_dept.dept_id)
     */
    private Long deptId;

    /**
     * 姓名
     */
    private String childName;

    /**
     * 昵称
     */
    private String nickName;

    /**
     * 出生日期
     */
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date birthday;

    /**
     * 性别 (0男 1女 2未知)
     */
    private String sex;

    /**
     * 头像地址
     */
    private String avatar;

    /**
     * 帐号状态 (0正常 1停用)
     */
    private String status;

    /**
     * 删除标志 (0代表存在 2代表删除)
     */
    @TableLogic
    private String delFlag;

}
