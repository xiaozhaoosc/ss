package com.kenzhao.smallsteps.parent.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.kenzhao.smallsteps.parent.domain.ParentGrowth;
import com.kenzhao.smallsteps.parent.domain.bo.ParentGrowthBo;
import com.kenzhao.smallsteps.parent.domain.vo.ParentGrowthVo;
import com.kenzhao.smallsteps.parent.mapper.ParentGrowthMapper;
import com.kenzhao.smallsteps.parent.service.IParentGrowthService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

/**
 * 家长成长观察服务实现
 */
@Service
@RequiredArgsConstructor
public class ParentGrowthServiceImpl implements IParentGrowthService {

    private final ParentGrowthMapper parentGrowthMapper;

    @Override
    public ParentGrowthVo getEmotionDaily(Long userId, String date) {
        // 查找用户的情绪记录
        LambdaQueryWrapper<ParentGrowth> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ParentGrowth::getUserId, userId);
        wrapper.eq(ParentGrowth::getDate, date);
        List<ParentGrowth> growths = parentGrowthMapper.selectList(wrapper);

        ParentGrowthVo vo = new ParentGrowthVo();
        vo.setUserId(userId);
        vo.setDate(date);

        if (!growths.isEmpty()) {
            ParentGrowth growth = growths.get(0);
            vo.setEmotionState(growth.getEmotionState());
            vo.setEmotionScore(growth.getEmotionScore());
            vo.setObservation(growth.getObservation());
        } else {
            // 默认值
            vo.setEmotionState("中性");
            vo.setEmotionScore(5);
            vo.setObservation("暂无观察记录");
        }

        return vo;
    }

    @Override
    public ParentGrowthVo getAbilityRadar(Long userId, String period) {
        // 查找用户的能力记录
        LambdaQueryWrapper<ParentGrowth> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ParentGrowth::getUserId, userId);
        wrapper.isNotNull(ParentGrowth::getAbilityType);
        List<ParentGrowth> growths = parentGrowthMapper.selectList(wrapper);

        ParentGrowthVo vo = new ParentGrowthVo();
        vo.setUserId(userId);

        List<ParentGrowthVo.AbilityData> abilityDataList = new ArrayList<>();

        // 能力类型列表
        String[] abilityTypes = {"专注力", "执行力", "情绪管理", "社交能力", "学习能力"};

        for (String abilityType : abilityTypes) {
            ParentGrowthVo.AbilityData abilityData = new ParentGrowthVo.AbilityData();
            abilityData.setAbilityType(abilityType);
            
            // 查找该能力的最新记录
            LambdaQueryWrapper<ParentGrowth> abilityWrapper = new LambdaQueryWrapper<>();
            abilityWrapper.eq(ParentGrowth::getUserId, userId);
            abilityWrapper.eq(ParentGrowth::getAbilityType, abilityType);
            abilityWrapper.orderByDesc(ParentGrowth::getDate);
            List<ParentGrowth> abilityGrowths = parentGrowthMapper.selectList(abilityWrapper);

            if (!abilityGrowths.isEmpty()) {
                abilityData.setAbilityScore(abilityGrowths.get(0).getAbilityScore());
            } else {
                abilityData.setAbilityScore(5); // 默认值
            }

            abilityDataList.add(abilityData);
        }

        vo.setAbilityDataList(abilityDataList);
        return vo;
    }

    @Override
    public List<ParentGrowthVo> getGrowthTrack(Long userId, String startDate, String endDate) {
        // 查找用户的成长记录
        LambdaQueryWrapper<ParentGrowth> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ParentGrowth::getUserId, userId);
        wrapper.ge(ParentGrowth::getDate, startDate);
        wrapper.le(ParentGrowth::getDate, endDate);
        wrapper.orderByAsc(ParentGrowth::getDate);
        List<ParentGrowth> growths = parentGrowthMapper.selectList(wrapper);

        List<ParentGrowthVo> voList = new ArrayList<>();

        for (ParentGrowth growth : growths) {
            ParentGrowthVo vo = new ParentGrowthVo();
            vo.setUserId(userId);
            vo.setDate(growth.getDate());
            vo.setEmotionState(growth.getEmotionState());
            vo.setEmotionScore(growth.getEmotionScore());
            vo.setObservation(growth.getObservation());
            voList.add(vo);
        }

        return voList;
    }

    @Override
    public boolean recordEmotion(ParentGrowthBo bo) {
        ParentGrowth growth = new ParentGrowth();
        growth.setUserId(bo.getUserId());
        growth.setDate(bo.getDate());
        growth.setEmotionState(bo.getEmotionState());
        growth.setEmotionScore(bo.getEmotionScore());
        growth.setObservation(bo.getObservation());
        growth.setCreateTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
        growth.setUpdateTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));

        return parentGrowthMapper.insert(growth) > 0;
    }
}