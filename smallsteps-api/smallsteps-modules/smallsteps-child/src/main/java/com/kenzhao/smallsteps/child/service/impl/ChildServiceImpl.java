package com.kenzhao.smallsteps.child.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.kenzhao.smallsteps.child.mapper.ChildMapper;
import com.kenzhao.smallsteps.child.service.IChildService;
import com.kenzhao.smallsteps.common.ss.domain.Child;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import com.kenzhao.smallsteps.common.satoken.utils.LoginHelper;
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
    public Child selectChildById(Long id) {
        return baseMapper.selectById(id);
    }

    @Override
    public List<Child> selectChildList(Child child) {
        Long parentId = child.getParentId() != null ? child.getParentId() : LoginHelper.getUserId();
        return baseMapper.selectList(new LambdaQueryWrapper<Child>()
            .eq(Child::getParentId, parentId)
            .like(child.getNickname() != null, Child::getNickname, child.getNickname())
            .eq(child.getGender() != null, Child::getGender, child.getGender()));
    }

    @Override
    public int insertChild(Child child) {
        if (child.getParentId() == null) {
            child.setParentId(LoginHelper.getUserId());
        }
        return baseMapper.insert(child);
    }

    @Override
    public int updateChild(Child child) {
        return baseMapper.updateById(child);
    }

    @Override
    public int deleteChildByIds(Long[] ids) {
        return baseMapper.deleteByIds(Arrays.asList(ids));
    }

    @Override
    public int deleteChildById(Long id) {
        return baseMapper.deleteById(id);
    }
}
