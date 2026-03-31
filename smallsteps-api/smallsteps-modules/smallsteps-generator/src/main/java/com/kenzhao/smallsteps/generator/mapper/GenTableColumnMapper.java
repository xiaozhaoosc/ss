package com.kenzhao.smallsteps.generator.mapper;

import com.baomidou.mybatisplus.annotation.InterceptorIgnore;
import com.kenzhao.smallsteps.common.mybatis.core.mapper.BaseMapperPlus;
import com.kenzhao.smallsteps.generator.domain.GenTableColumn;

/**
 * 业务字段 数据层
 *
 * @author 赵轩
 */
@InterceptorIgnore(dataPermission = "true", tenantLine = "true")
public interface GenTableColumnMapper extends BaseMapperPlus<GenTableColumn, GenTableColumn> {

}
