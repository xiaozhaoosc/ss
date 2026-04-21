package com.kenzhao.smallsteps.system.domain.vo;

import cn.hutool.core.lang.tree.Tree;

import java.util.List;

/**
 * 角色部门列表树信息
 *
 * @param checkedKeys 选中部门列表
 * @param depts       下拉树结构列表
 * @author 赵轩
 */
public record SysDeptTreeSelectVo(List<Long> checkedKeys, List<Tree<Long>> depts) {
}
