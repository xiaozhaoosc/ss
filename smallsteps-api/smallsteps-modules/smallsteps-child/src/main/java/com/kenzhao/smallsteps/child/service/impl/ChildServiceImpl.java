package com.kenzhao.smallsteps.child.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.kenzhao.smallsteps.child.mapper.ChildMapper;
import com.kenzhao.smallsteps.child.service.IChildService;
import com.kenzhao.smallsteps.common.ss.domain.Child;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;

/**
 * 儿童信息Service业务层处理
 *
 * @author 赵轩
 * @date 2026-04-14
 */
@Service
@RequiredArgsConstructor
public class ChildServiceImpl implements IChildService {

    private final ChildMapper baseMapper;

    @Override
    public Child selectChildByChildId(Long childId) {
        return baseMapper.selectById(childId);
    }

    @Override
    public List<Child> selectChildList(Child child) {
        return baseMapper.selectList(new LambdaQueryWrapper<Child>()
            .eq(child.getDeptId() != null, Child::getDeptId, child.getDeptId())
            .like(child.getChildName() != null, Child::getChildName, child.getChildName())
            .eq(child.getSex() != null, Child::getSex, child.getSex())
            .eq(child.getStatus() != null, Child::getStatus, child.getStatus()));
    }

    @Override
    public int insertChild(Child child) {
        return baseMapper.insert(child);
    }

    @Override
    public int updateChild(Child child) {
        return baseMapper.updateById(child);
    }

    @Override
    public int deleteChildByChildIds(Long[] childIds) {
        return baseMapper.deleteByIds(Arrays.asList(childIds));
    }

    @Override
    public int deleteChildByChildId(Long childId) {
        return baseMapper.deleteById(childId);
    }
}
