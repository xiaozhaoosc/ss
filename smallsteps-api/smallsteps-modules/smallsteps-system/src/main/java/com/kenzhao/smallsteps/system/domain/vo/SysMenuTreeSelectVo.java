package com.kenzhao.smallsteps.system.domain.vo;

import cn.hutool.core.lang.tree.Tree;

import java.util.List;

/**
 * 角色菜单列表树信息
 *
 * @param checkedKeys 选中菜单列表
 * @param menus       菜单下拉树结构列表
 * @author 赵轩
 */
public record SysMenuTreeSelectVo(List<Long> checkedKeys, List<Tree<Long>> menus) {
}
