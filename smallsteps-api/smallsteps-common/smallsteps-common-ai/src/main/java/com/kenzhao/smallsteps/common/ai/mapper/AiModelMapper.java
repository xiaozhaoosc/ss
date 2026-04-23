package com.kenzhao.smallsteps.common.ai.mapper;

import com.kenzhao.smallsteps.common.ai.domain.AiModel;
import com.kenzhao.smallsteps.common.ai.domain.vo.AiModelVo;
import com.kenzhao.smallsteps.common.mybatis.core.mapper.BaseMapperPlus;
import org.apache.ibatis.annotations.Mapper;

/**
 * AI模型Mapper接口
 * 
 * @author kenzhao
 * @date 2026-02-01
 */
@Mapper
public interface AiModelMapper extends BaseMapperPlus<AiModel, AiModelVo> {
}
