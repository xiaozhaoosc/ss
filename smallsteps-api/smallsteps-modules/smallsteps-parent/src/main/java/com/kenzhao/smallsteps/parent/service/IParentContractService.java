package com.kenzhao.smallsteps.parent.service;

import com.kenzhao.smallsteps.common.ss.domain.vo.ParentContractVo;
import com.kenzhao.smallsteps.common.ss.domain.bo.ParentContractBo;
import com.kenzhao.smallsteps.common.mybatis.core.page.TableDataInfo;
import com.kenzhao.smallsteps.common.mybatis.core.page.PageQuery;

import java.util.Collection;
import java.util.List;

/**
 * 亲子契约Service接口
 *
 * @author 赵轩
 * @date 2026-02-01
 */
public interface IParentContractService {

    /**
     * 查询亲子契约
     */
    ParentContractVo queryById(Long contractId);

    /**
     * 查询亲子契约列表
     */
    TableDataInfo<ParentContractVo> queryPageList(ParentContractBo bo, PageQuery pageQuery);

    /**
     * 查询亲子契约列表
     */
    List<ParentContractVo> queryList(ParentContractBo bo);

    /**
     * 新增亲子契约
     */
    Boolean insertByBo(ParentContractBo bo);

    /**
     * 修改亲子契约
     */
    Boolean updateByBo(ParentContractBo bo);

    /**
     * 校验并批量删除亲子契约信息
     */
    Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);
}
