package com.kenzhao.smallsteps.parent.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.kenzhao.smallsteps.parent.domain.ParentTool;
import com.kenzhao.smallsteps.parent.domain.bo.ParentToolBo;
import com.kenzhao.smallsteps.parent.domain.vo.ParentToolVo;
import com.kenzhao.smallsteps.parent.mapper.ParentToolMapper;
import com.kenzhao.smallsteps.parent.service.IParentToolService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

/**
 * 家长辅助工具服务实现
 */
@Service
@RequiredArgsConstructor
public class ParentToolServiceImpl implements IParentToolService {

    private final ParentToolMapper parentToolMapper;

    @Override
    public ParentToolVo getEmotionFirstAid(Long userId) {
        // 查找用户的情绪急救包配置
        LambdaQueryWrapper<ParentTool> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ParentTool::getUserId, userId);
        wrapper.eq(ParentTool::getToolType, "emotion_first_aid");
        List<ParentTool> tools = parentToolMapper.selectList(wrapper);

        ParentToolVo vo = new ParentToolVo();
        vo.setToolType("emotion_first_aid");
        vo.setToolName("情绪急救包");

        if (!tools.isEmpty()) {
            ParentTool tool = tools.get(0);
            vo.setToolId(tool.getToolId());
            vo.setFirstAidConfig(tool.getFirstAidConfig());
        } else {
            // 默认配置
            vo.setFirstAidConfig("{\"strategies\": [{\"emotion\": \"生气\",\"actions\": [\"深呼吸\", \"数到十\", \"离开现场\"]},{\"emotion\": \"伤心\",\"actions\": [\"拥抱\", \"倾听\", \"安慰\"]},{\"emotion\": \"焦虑\",\"actions\": [\"放松训练\", \"分解任务\", \"积极暗示\"]}]}");
        }

        return vo;
    }

    @Override
    public boolean updateEmotionFirstAid(ParentToolBo bo) {
        // 查找用户的情绪急救包配置
        LambdaQueryWrapper<ParentTool> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ParentTool::getUserId, bo.getUserId());
        wrapper.eq(ParentTool::getToolType, "emotion_first_aid");
        List<ParentTool> tools = parentToolMapper.selectList(wrapper);

        ParentTool tool;
        if (!tools.isEmpty()) {
            // 更新现有配置
            tool = tools.get(0);
            tool.setFirstAidConfig(bo.getFirstAidConfig());
            tool.setUpdateTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            return parentToolMapper.updateById(tool) > 0;
        } else {
            // 创建新配置
            tool = new ParentTool();
            tool.setUserId(bo.getUserId());
            tool.setToolType("emotion_first_aid");
            tool.setToolName("情绪急救包");
            tool.setFirstAidConfig(bo.getFirstAidConfig());
            tool.setCreateTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            tool.setUpdateTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            return parentToolMapper.insert(tool) > 0;
        }
    }

    @Override
    public List<ParentToolVo> getParentGuide(String type) {
        List<ParentToolVo> voList = new ArrayList<>();

        // 模拟数据
        if ("task_management".equals(type)) {
            ParentToolVo vo1 = new ParentToolVo();
            vo1.setGuideType("task_management");
            vo1.setGuideTitle("如何制定有效的任务计划");
            vo1.setGuideContent("1. 分解任务为小步骤\n2. 设置合理的时间限制\n3. 提供明确的奖励机制\n4. 及时给予反馈");
            voList.add(vo1);

            ParentToolVo vo2 = new ParentToolVo();
            vo2.setGuideType("task_management");
            vo2.setGuideTitle("如何鼓励孩子完成任务");
            vo2.setGuideContent("1. 给予积极的肯定\n2. 设定可实现的目标\n3. 参与孩子的任务过程\n4. 庆祝每一个小进步");
            voList.add(vo2);
        } else if ("emotion_management".equals(type)) {
            ParentToolVo vo1 = new ParentToolVo();
            vo1.setGuideType("emotion_management");
            vo1.setGuideTitle("如何帮助孩子管理情绪");
            vo1.setGuideContent("1. 教会孩子识别情绪\n2. 提供情绪表达的渠道\n3. 以身作则，展示情绪管理\n4. 建立情绪安全的环境");
            voList.add(vo1);

            ParentToolVo vo2 = new ParentToolVo();
            vo2.setGuideType("emotion_management");
            vo2.setGuideTitle("如何应对孩子的情绪爆发");
            vo2.setGuideContent("1. 保持冷静\n2. 给予空间和时间\n3. 事后进行情绪复盘\n4. 建立情绪爆发的应对策略");
            voList.add(vo2);
        }

        return voList;
    }

    @Override
    public List<ParentToolVo> getContractTemplate() {
        List<ParentToolVo> voList = new ArrayList<>();

        // 模拟数据
        ParentToolVo vo1 = new ParentToolVo();
        vo1.setTemplateId(1L);
        vo1.setTemplateName("日常任务契约");
        vo1.setTemplateContent("甲方：家长\n乙方：孩子\n\n1. 乙方每天需要完成以下任务：\n   - 按时完成作业\n   - 整理自己的房间\n   - 帮助家长做一件家务\n\n2. 完成任务后，乙方可以获得：\n   - 星星奖励\n   - 周末游玩时间\n   - 心仪的小礼物\n\n3. 双方签字：\n   家长：________\n   孩子：________\n   日期：________");
        voList.add(vo1);

        ParentToolVo vo2 = new ParentToolVo();
        vo2.setTemplateId(2L);
        vo2.setTemplateName("情绪管理契约");
        vo2.setTemplateContent("甲方：家长\n乙方：孩子\n\n1. 当乙方感到情绪激动时，应该：\n   - 深呼吸数到十\n   - 告诉家长自己的感受\n   - 到安静的地方冷静一下\n\n2. 当乙方成功管理情绪时，甲方会：\n   - 给予表扬和肯定\n   - 增加星星奖励\n   - 分享快乐的时光\n\n3. 双方签字：\n   家长：________\n   孩子：________\n   日期：________");
        voList.add(vo2);

        return voList;
    }
}