#ifndef _ADHD_UI_H_
#define _ADHD_UI_H_

#include <lvgl.h>
#include <vector>
#include <string>

class AdhdUi {
public:
    AdhdUi(lv_obj_t* parent);
    ~AdhdUi();

    void ShowTaskList(const std::vector<std::pair<std::string, bool>>& tasks, int current_index);
    void ShowFocusMode(int remaining_seconds, int total_seconds);
    void SetVisible(bool visible);

private:
    lv_obj_t* container_;
    lv_obj_t* list_container_ = nullptr;
    lv_obj_t* focus_container_ = nullptr;
    lv_obj_t* arc_timer_ = nullptr;
    lv_obj_t* time_label_ = nullptr;

    void CreateTaskList();
    void CreateFocusView();
};

#endif // _ADHD_UI_H_
