package com.kenzhao.smallsteps.system.domain;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import java.util.Date;

/**
 * 能量森林记录 (Entity)
 */
@Data
@TableName("sys_energy_record")
public class SysEnergyRecord {
    @TableId
    private Long id;
    private Long childId;
    private Integer amount;    // 能量值 (+为获得, -为消耗)
    private String source;     // 来源 (TASK_COMPLETED, IRRIGATION)
    private Date createTime;
}
