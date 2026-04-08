package compackage com.kenzhao.smallsteps.child.domain;

import com.baomidou.mybatispackage com.kenzhao.smallsteps.child.domain;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
package com.kenzhao.smallsteps.child.domain;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.kenzhao.smallsteps.commonpackage com.kenzhao.smallsteps.child.domain;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.kenzhao.smallsteps.common.core.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**package com.kenzhao.smallsteps.child.domain;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.kenzhao.smallsteps.common.core.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 儿童任务执行记录
 */
@Data
@EqualsAndHashCode(cpackage com.kenzhao.smallsteps.child.domain;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.kenzhao.smallsteps.common.core.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 儿童任务执行记录
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("child_task")
public class ChildTaskpackage com.kenzhao.smallstepspackage com.kenzhao.smallsteps.child.domain;

import com.kenzhao.smallsteps.common.core.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndpackage com.kenzhao.smallsteps.child.domain;

import com.kenzhao.smallsteps.common.core.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 儿童任务执行实体
 */
@Data
package com.kenzhao.smallsteps.child.domain;

import com.kenzhao.smallsteps.common.core.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 儿童任务执行实体
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class ChildTask extends BaseEntity {
package com.kenzhao.smallsteps.child.domain;

import com.kenzhao.smallsteps.common.core.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 儿童任务执行实体
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class ChildTask extends BaseEntity {

    /**
     * 任务ID
     */
    private Long taskIdpackage com.kenzhao.smallsteps.child.domain;

import com.kenzhao.smallsteps.common.core.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 儿童任务执行实体
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class ChildTask extends BaseEntity {

    /**
     * 任务ID
     */
    private Long taskId;

    /**
     * 儿童ID
     */
    private Longpackage com.kenzhao.smallsteps.child.domain;

import com.kenzhao.smallsteps.common.core.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 儿童任务执行实体
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class ChildTask extends BaseEntity {

    /**
     * 任务ID
     */
    private Long taskId;

    /**
     * 儿童ID
     */
    private Long childId;

    /**
     * 任务状态（0：未开始，package com.kenzhao.smallsteps.child.domain;

import com.kenzhao.smallsteps.common.core.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 儿童任务执行实体
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class ChildTask extends BaseEntity {

    /**
     * 任务ID
     */
    private Long taskId;

    /**
     * 儿童ID
     */
    private Long childId;

    /**
     * 任务状态（0：未开始，1：进行中，2：已完成，3：已失败）
     */
    private String status;

    /**package com.kenzhao.smallsteps.child.domain;

import com.kenzhao.smallsteps.common.core.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 儿童任务执行实体
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class ChildTask extends BaseEntity {

    /**
     * 任务ID
     */
    private Long taskId;

    /**
     * 儿童ID
     */
    private Long childId;

    /**
     * 任务状态（0：未开始，1：进行中，2：已完成，3：已失败）
     */
    private String status;

    /**
     * 完成时间
     */
    private String completeTime;

package com.kenzhao.smallsteps.child.domain;

import com.kenzhao.smallsteps.common.core.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 儿童任务执行实体
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class ChildTask extends BaseEntity {

    /**
     * 任务ID
     */
    private Long taskId;

    /**
     * 儿童ID
     */
    private Long childId;

    /**
     * 任务状态（0：未开始，1：进行中，2：已完成，3：已失败）
     */
    private String status;

    /**
     * 完成时间
     */
    private String completeTime;

    /**
     * NFC标签ID
package com.kenzhao.smallsteps.child.domain;

import com.kenzhao.smallsteps.common.core.domain.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 儿童任务执行实体
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class ChildTask extends BaseEntity {

    /**
     * 任务ID
     */
    private Long taskId;

    /**
     * 儿童ID
     */
    private Long childId;

    /**
     * 任务状态（0：未开始，1：进行中，2：已完成，3：已失败）
     */
    private String status;

    /**
     * 完成时间
     */
    private String completeTime;

    /**
     * NFC标签ID
     */
    private String nfcTagId;

    /**
     *