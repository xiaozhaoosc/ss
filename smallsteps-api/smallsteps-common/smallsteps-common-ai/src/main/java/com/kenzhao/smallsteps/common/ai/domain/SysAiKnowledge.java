package com.kenzhao.smallsteps.common.ai.domain;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import java.util.Date;

@Data
@TableName("sys_ai_knowledge")
public class SysAiKnowledge {
    @TableId
    private Long id;
    private String title;
    private String contentType;
    private String content;
    private String keywords;
    private String status;
    private String createBy;
    private Date createTime;
    private String updateBy;
    private Date updateTime;
    private String remark;
}
