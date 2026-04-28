package com.kenzhao.smallsteps.child.mapper;

import com.kenzhao.smallsteps.common.mybatis.core.mapper.BaseMapperPlus;
import com.kenzhao.smallsteps.common.ss.domain.EmotionRecord;
import org.apache.ibatis.annotations.Mapper;

/**
 * 儿童情绪记录Mapper
 */
@Mapper
public interface EmotionRecordMapper extends BaseMapperPlus<EmotionRecord, EmotionRecord> {
}
