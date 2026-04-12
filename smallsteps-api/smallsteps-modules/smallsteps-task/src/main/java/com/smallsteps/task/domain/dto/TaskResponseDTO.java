package com.smallsteps.task.domain.dto;

public class TaskResponseDTO {
    private Long id;
    private String title;
    private Integer rewardPoints;

    public TaskResponseDTO(Long id, String title, Integer rewardPoints) {
        this.id = id;
        this.title = title;
        this.rewardPoints = rewardPoints;
    }
    
    public Long getId() { return id; }
    public String getTitle() { return title; }
    public Integer getRewardPoints() { return rewardPoints; }
}