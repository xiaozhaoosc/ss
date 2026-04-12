package com.smallsteps.task.domain.dto;

public class TaskCreateDTO {
    private String title;
    private Integer rewardPoints;
    private Long childId;

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public Integer getRewardPoints() { return rewardPoints; }
    public void setRewardPoints(Integer rewardPoints) { this.rewardPoints = rewardPoints; }
    public Long getChildId() { return childId; }
    public void setChildId(Long childId) { this.childId = childId; }
}