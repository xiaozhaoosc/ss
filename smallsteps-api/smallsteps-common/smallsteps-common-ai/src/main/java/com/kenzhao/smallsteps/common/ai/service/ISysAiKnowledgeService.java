package com.kenzhao.smallsteps.common.ai.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.kenzhao.smallsteps.common.ai.domain.SysAiKnowledge;
import com.kenzhao.smallsteps.common.mybatis.core.page.PageQuery;
import com.kenzhao.smallsteps.common.mybatis.core.page.TableDataInfo;
import java.util.List;

public interface ISysAiKnowledgeService extends IService<SysAiKnowledge> {
    TableDataInfo<SysAiKnowledge> queryPageList(SysAiKnowledge bo, PageQuery pageQuery);
    void syncToVectorStore(Long id);
    List<String> hybridSearch(String query, int topK);
}
