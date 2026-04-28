package com.kenzhao.smallsteps.parent.mapper;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.kenzhao.smallsteps.common.mybatis.core.mapper.BaseMapperPlus;
import com.kenzhao.smallsteps.common.ss.domain.SsFamilyJoinRequest;
import org.apache.ibatis.annotations.Param;
import java.util.List;

public interface FamilyJoinRequestMapper extends BaseMapperPlus<SsFamilyJoinRequest, SsFamilyJoinRequest> {

    default List<SsFamilyJoinRequest> selectPendingByDeptId(@Param("deptId") Long deptId) {
        return this.selectList(new LambdaQueryWrapper<SsFamilyJoinRequest>()
            .eq(SsFamilyJoinRequest::getStatus, "0")
            .orderByDesc(SsFamilyJoinRequest::getCreateTime));
    }

    default List<SsFamilyJoinRequest> selectByApplicantId(@Param("applicantId") Long applicantId) {
        return this.selectList(new LambdaQueryWrapper<SsFamilyJoinRequest>()
            .eq(SsFamilyJoinRequest::getApplicantId, applicantId)
            .orderByDesc(SsFamilyJoinRequest::getCreateTime));
    }
}