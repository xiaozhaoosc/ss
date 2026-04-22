package com.kenzhao.smallsteps.common.ai.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.kenzhao.smallsteps.common.ai.domain.AiModel;
import org.apache.ibatis.annotations.Mapper;

/**
 * AI模型Mapper接口
 * 
 * @author kenzhao
 * @date 2026-02-01
 */
@Mapper
public interface AiModelMapper extends BaseMapper<AiModel> {
}
