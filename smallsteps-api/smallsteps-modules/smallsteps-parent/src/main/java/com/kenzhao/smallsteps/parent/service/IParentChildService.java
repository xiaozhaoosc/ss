package com.kenzhao.smallsteps.parent.service;

import com.kenzhao.smallsteps.parent.dto.CreateChildRequest;

/**
 * 家长创建孩子账号服务接口
 */
public interface IParentChildService {

    /**
     * 创建孩子账号
     * 
     * @param request 创建请求
     * @return 孩子用户ID
     */
    Long createChildAccount(CreateChildRequest request);
}