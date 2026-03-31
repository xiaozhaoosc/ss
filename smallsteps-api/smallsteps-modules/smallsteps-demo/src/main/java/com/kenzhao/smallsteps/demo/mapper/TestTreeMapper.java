package com.kenzhao.smallsteps.demo.mapper;

import com.kenzhao.smallsteps.common.mybatis.annotation.DataColumn;
import com.kenzhao.smallsteps.common.mybatis.annotation.DataPermission;
import com.kenzhao.smallsteps.common.mybatis.core.mapper.BaseMapperPlus;
import com.kenzhao.smallsteps.demo.domain.TestTree;
import com.kenzhao.smallsteps.demo.domain.vo.TestTreeVo;

/**
 * 测试树表Mapper接口
 *
 * @author 赵轩
 * @date 2021-07-26
 */
@DataPermission({
    @DataColumn(key = "deptName", value = "dept_id"),
    @DataColumn(key = "userName", value = "user_id")
})
public interface TestTreeMapper extends BaseMapperPlus<TestTree, TestTreeVo> {

}
