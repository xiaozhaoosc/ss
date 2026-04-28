package com.kenzhao.smallsteps.parent.mapper;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.kenzhao.smallsteps.common.mybatis.core.mapper.BaseMapperPlus;
import com.kenzhao.smallsteps.common.ss.domain.SsFamilyInvite;
import org.apache.ibatis.annotations.Param;

public interface FamilyInviteMapper extends BaseMapperPlus<SsFamilyInvite, SsFamilyInvite> {

    default SsFamilyInvite selectByInviteCode(@Param("inviteCode") String inviteCode) {
        return this.selectOne(new LambdaQueryWrapper<SsFamilyInvite>()
            .eq(SsFamilyInvite::getInviteCode, inviteCode)
            .eq(SsFamilyInvite::getDelFlag, "0"));
    }
}