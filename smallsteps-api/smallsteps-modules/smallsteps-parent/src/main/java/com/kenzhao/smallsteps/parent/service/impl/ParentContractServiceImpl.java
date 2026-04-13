package com.kenzhao.smallsteps.parent.service.impl;

import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.kenzhao.smallsteps.common.core.utils.MapstructUtils;
import com.kenzhao.smallsteps.common.core.utils.StringUtils;
import com.kenzhao.smallsteps.common.mybatis.core.page.PageQuery;
import com.kenzhao.smallsteps.common.mybatis.core.page.TableDataInfo;
import com.kenzhao.smallsteps.common.ss.domain.ParentContract;
import com.kenzhao.smallsteps.common.ss.domain.bo.ParentContractBo;
import com.kenzhao.smallsteps.common.ss.domain.vo.ParentContractVo;
import com.kenzhao.smallsteps.parent.mapper.ParentContractMapper;
import com.kenzhao.smallsteps.parent.service.IParentContractService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.List;
import java.util.Map;

/**
 * 亲子契约Service业务层处理
 *
 * @author 赵轩
 * @date 2026-02-01
 */
@RequiredArgsConstructor
@Service
public class ParentContractServiceImpl implements IParentContractService {

    private final ParentContractMapper baseMapper;

    /**
     * 查询亲子契约
     */
    @Override
    public ParentContractVo queryById(Long contractId) {
        return baseMapper.selectVoById(contractId);
    }

    /**
     * 查询亲子契约列表
     */
    @Override
    public TableDataInfo<ParentContractVo> queryPageList(ParentContractBo bo, PageQuery pageQuery) {
        LambdaQueryWrapper<ParentContract> lqw = buildQueryWrapper(bo);
        Page<ParentContractVo> result = baseMapper.selectVoPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    /**
     * 查询亲子契约列表
     */
    @Override
    public List<ParentContractVo> queryList(ParentContractBo bo) {
        LambdaQueryWrapper<ParentContract> lqw = buildQueryWrapper(bo);
        return baseMapper.selectVoList(lqw);
    }

    private LambdaQueryWrapper<ParentContract> buildQueryWrapper(ParentContractBo bo) {
        Map<String, Object> params = bo.getParams();
        LambdaQueryWrapper<ParentContract> lqw = Wrappers.lambdaQuery();
        lqw.eq(bo.getParentId() != null, ParentContract::getParentId, bo.getParentId());
        lqw.eq(bo.getChildId() != null, ParentContract::getChildId, bo.getChildId());
        lqw.eq(StringUtils.isNotBlank(bo.getStatus()), ParentContract::getStatus, bo.getStatus());
        return lqw;
    }

    /**
     * 新增亲子契约
     */
    @Override
    public Boolean insertByBo(ParentContractBo bo) {
        ParentContract add = MapstructUtils.convert(bo, ParentContract.class);
        validEntityBeforeSave(add);
        boolean flag = baseMapper.insert(add) > 0;
        if (flag) {
            bo.setContractId(add.getContractId());
        }
        return flag;
    }

    /**
     * 修改亲子契约
     */
    @Override
    public Boolean updateByBo(ParentContractBo bo) {
        ParentContract update = MapstructUtils.convert(bo, ParentContract.class);
        validEntityBeforeSave(update);
        return baseMapper.updateById(update) > 0;
    }

    /**
     * 保存前的数据校验
     */
    private void validEntityBeforeSave(ParentContract entity) {
        // TODO 做一些数据校验,如唯一约束
    }

    /**
     * 批量删除亲子契约
     */
    @Override
    public Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid) {
        if (isValid) {
            // TODO 做一些业务上的校验,判断是否需要校验
        }
        return baseMapper.deleteByIds(ids) > 0;
    }
}
