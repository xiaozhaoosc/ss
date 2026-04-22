package com.kenzhao.smallsteps.child.service;

import com.kenzhao.smallsteps.common.ss.domain.Child;
import java.util.List;

/**
 * 儿童信息Service接口
 *
 * @author 赵轩
 * @date 2026-04-14
 */
public interface IChildService {
    /**
     * 查询儿童信息
     */
    Child selectChildById(Long id);

    /**
     * 查询儿童信息列表
     */
    List<Child> selectChildList(Child child);

    /**
     * 新增儿童信息
     */
    int insertChild(Child child);

    /**
     * 修改儿童信息
     */
    int updateChild(Child child);

    /**
     * 批量删除儿童信息
     */
    int deleteChildByIds(Long[] ids);

    /**
     * 删除儿童信息信息
     */
    int deleteChildById(Long id);
}
