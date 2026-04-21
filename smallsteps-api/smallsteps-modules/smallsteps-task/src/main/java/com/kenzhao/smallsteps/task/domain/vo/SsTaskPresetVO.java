package com.kenzhao.smallsteps.task.domain.vo;

import com.kenzhao.smallsteps.task.domain.SsTaskPreset;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;

/**
 * 任务预设视图对象
 */
@Data
@AutoMapper(target = SsTaskPreset.class)
public class SsTaskPresetVO implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    private Long id;
    private String category;
    private String title;
    private String desc;
    private Integer starBase;
    private String icon;
    private Integer difficulty;
    private String tags;
}
