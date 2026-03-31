#ifndef _ADHD_MANAGER_H_
#define _ADHD_MANAGER_H_

#include <string>
#include <vector>
#include <functional>
#include <esp_timer.h>

enum class FocusState {
    kIdle,
    kFocusing,
    kResting,
    kCompleted
};

struct AdhdTask {
    std::string title;
    bool completed;
    int duration_minutes;
};

class AdhdManager {
public:
    static AdhdManager& GetInstance();

    void Initialize();
    
    // 任务管理
    void AddTask(const std::string& title, int duration = 25);
    void CompleteTask(int index);
    const std::vector<AdhdTask>& GetTasks() const { return tasks_; }
    int GetCurrentTaskIndex() const { return current_task_index_; }
    void SetCurrentTaskIndex(int index) { current_task_index_ = index; }

    // 专注模式
    void StartFocus();
    void StopFocus();
    void PauseFocus();
    FocusState GetFocusState() const { return focus_state_; }
    int GetRemainingSeconds() const { return remaining_seconds_; }

    // 回调注册
    void OnStateChanged(std::function<void(FocusState)> callback) { state_changed_callback_ = callback; }
    void OnTick(std::function<void(int)> callback) { tick_callback_ = callback; }

private:
    AdhdManager() = default;
    
    std::vector<AdhdTask> tasks_;
    int current_task_index_ = -1;
    FocusState focus_state_ = FocusState::kIdle;
    int remaining_seconds_ = 0;
    
    esp_timer_handle_t focus_timer_ = nullptr;
    
    std::function<void(FocusState)> state_changed_callback_;
    std::function<void(int)> tick_callback_;

    static void TimerCallback(void* arg);
    void UpdateLogic();
};

#endif // _ADHD_MANAGER_H_
