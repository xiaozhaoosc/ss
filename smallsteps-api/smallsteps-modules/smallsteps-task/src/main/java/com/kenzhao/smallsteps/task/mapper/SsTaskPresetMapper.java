package com.kenzhao.smallsteps.task.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.kenzhao.smallsteps.task.domain.SsTaskPreset;
import org.apache.ibatis.annotations.Mapper;

/**
 * 任务预设Mapper接口
 */
@Mapper
public interface SsTaskPresetMapper extends BaseMapper<SsTaskPreset> {
}
