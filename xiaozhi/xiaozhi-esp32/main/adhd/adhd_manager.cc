#include "adhd_manager.h"
#include <esp_log.h>

#define TAG "AdhdManager"

AdhdManager& AdhdManager::GetInstance() {
    static AdhdManager instance;
    return instance;
}

#include "mcp_server.h"

void AdhdManager::Initialize() {
    ESP_LOGI(TAG, "Initializing ADHD Manager");
    
    esp_timer_create_args_t timer_args = {
        .callback = &AdhdManager::TimerCallback,
        .arg = this,
        .name = "focus_timer"
    };
    ESP_ERROR_CHECK(esp_timer_create(&timer_args, &focus_timer_));

    // 注册 ADHD 相关的 MCP 工具以便远程控制
    // McpServer::GetInstance().AddAdhdTools();

    // 默认添加几个测试任务
    AddTask("整理书包", 5);
    AddTask("写数学作业", 20);
    AddTask("喝水休息", 2);
}

void AdhdManager::AddTask(const std::string& title, int duration) {
    tasks_.push_back({title, false, duration});
}

void AdhdManager::CompleteTask(int index) {
    if (index >= 0 && index < tasks_.size()) {
        tasks_[index].completed = true;
    }
}

void AdhdManager::StartFocus() {
    if (focus_state_ == FocusState::kFocusing) return;
    
    if (current_task_index_ == -1 && !tasks_.empty()) {
        current_task_index_ = 0;
    }
    
    if (current_task_index_ != -1) {
        remaining_seconds_ = tasks_[current_task_index_].duration_minutes * 60;
        focus_state_ = FocusState::kFocusing;
        ESP_ERROR_CHECK(esp_timer_start_periodic(focus_timer_, 1000000)); // 1 second
        
        if (state_changed_callback_) state_changed_callback_(focus_state_);
    }
}

void AdhdManager::StopFocus() {
    esp_timer_stop(focus_timer_);
    focus_state_ = FocusState::kIdle;
    if (state_changed_callback_) state_changed_callback_(focus_state_);
}

void AdhdManager::PauseFocus() {
    esp_timer_stop(focus_timer_);
    focus_state_ = FocusState::kIdle; // 简化为返回 Idle，以后可以细化为 Paused
    if (state_changed_callback_) state_changed_callback_(focus_state_);
}

void AdhdManager::TimerCallback(void* arg) {
    auto manager = static_cast<AdhdManager*>(arg);
    manager->UpdateLogic();
}

#include "board.h"
#include "display.h"

void AdhdManager::UpdateLogic() {
    if (remaining_seconds_ > 0) {
        remaining_seconds_--;
        if (tick_callback_) tick_callback_(remaining_seconds_);
        
        // 每秒刷新界面以显示倒计时
        auto display = Board::GetInstance().GetDisplay();
        if (display) display->SetAdhdUiVisible(true);
    } else {
        esp_timer_stop(focus_timer_);
        focus_state_ = FocusState::kCompleted;
        if (state_changed_callback_) state_changed_callback_(focus_state_);
        
        // 任务完成后通知 UI 显示奖励或反馈
        auto display = Board::GetInstance().GetDisplay();
        if (display) display->SetAdhdUiVisible(true);
        
        // TODO: 触发震动和灯语反馈
    }
}
