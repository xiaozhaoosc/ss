#include "adhd_ui.h"
#include <format>

AdhdUi::AdhdUi(lv_obj_t* parent) {
    container_ = lv_obj_create(parent);
    lv_obj_set_size(container_, LV_HOR_RES, LV_VER_RES);
    lv_obj_set_style_bg_color(container_, lv_color_hex(0x000000), 0);
    lv_obj_set_style_border_width(container_, 0, 0);
    lv_obj_set_style_pad_all(container_, 0, 0);
    lv_obj_add_flag(container_, LV_OBJ_FLAG_HIDDEN);
}

AdhdUi::~AdhdUi() {
    if (container_) lv_obj_del(container_);
}

void AdhdUi::SetVisible(bool visible) {
    if (visible) {
        lv_obj_remove_flag(container_, LV_OBJ_FLAG_HIDDEN);
    } else {
        lv_obj_add_flag(container_, LV_OBJ_FLAG_HIDDEN);
    }
}

void AdhdUi::ShowTaskList(const std::vector<std::pair<std::string, bool>>& tasks, int current_index) {
    if (focus_container_) lv_obj_add_flag(focus_container_, LV_OBJ_FLAG_HIDDEN);
    
    if (!list_container_) {
        list_container_ = lv_obj_create(container_);
        lv_obj_set_size(list_container_, LV_HOR_RES, LV_VER_RES);
        lv_obj_set_flex_flow(list_container_, LV_FLEX_FLOW_COLUMN);
        lv_obj_set_style_bg_opa(list_container_, LV_OPA_TRANSP, 0);
        lv_obj_set_style_border_width(list_container_, 0, 0);
    }
    
    lv_obj_remove_flag(list_container_, LV_OBJ_FLAG_HIDDEN);
    lv_obj_clean(list_container_);

    lv_obj_t* title = lv_label_create(list_container_);
    lv_label_set_text(title, "今日步小步");
    lv_obj_set_style_text_font(title, &lv_font_montserrat_14, 0); // 假定有中文字库或用默认
    lv_obj_set_style_text_color(title, lv_color_hex(0xFFCC00), 0);
    lv_obj_align(title, LV_ALIGN_TOP_MID, 0, 5);

    for (int i = 0; i < tasks.size(); ++i) {
        lv_obj_t* item = lv_obj_create(list_container_);
        lv_obj_set_size(item, LV_HOR_RES - 10, 30);
        lv_obj_set_style_bg_color(item, (i == current_index) ? lv_color_hex(0x333333) : lv_color_hex(0x111111), 0);
        lv_obj_set_style_border_width(item, (i == current_index) ? 1 : 0, 0);
        lv_obj_set_style_border_color(item, lv_color_hex(0xFFCC00), 0);
        
        lv_obj_t* label = lv_label_create(item);
        lv_label_set_text(label, tasks[i].first.c_str());
        lv_obj_align(label, LV_ALIGN_LEFT_MID, 5, 0);
        
        if (tasks[i].second) {
            lv_obj_t* check = lv_label_create(item);
            lv_label_set_text(check, LV_SYMBOL_OK);
            lv_obj_align(check, LV_ALIGN_RIGHT_MID, -5, 0);
            lv_obj_set_style_text_color(check, lv_color_hex(0x00FF00), 0);
        }
    }
}

void AdhdUi::ShowFocusMode(int remaining_seconds, int total_seconds) {
    if (list_container_) lv_obj_add_flag(list_container_, LV_OBJ_FLAG_HIDDEN);
    
    if (!focus_container_) {
        focus_container_ = lv_obj_create(container_);
        lv_obj_set_size(focus_container_, LV_HOR_RES, LV_VER_RES);
        lv_obj_set_style_bg_opa(focus_container_, LV_OPA_TRANSP, 0);
        lv_obj_set_style_border_width(focus_container_, 0, 0);

        arc_timer_ = lv_arc_create(focus_container_);
        lv_obj_set_size(arc_timer_, 100, 100);
        lv_arc_set_rotation(arc_timer_, 270);
        lv_arc_set_bg_angles(arc_timer_, 0, 360);
        lv_obj_set_style_arc_width(arc_timer_, 8, LV_PART_MAIN);
        lv_obj_set_style_arc_width(arc_timer_, 8, LV_PART_INDICATOR);
        lv_obj_center(arc_timer_);
        lv_obj_remove_flag(arc_timer_, LV_OBJ_FLAG_CLICKABLE);

        time_label_ = lv_label_create(focus_container_);
        lv_obj_set_style_text_font(time_label_, &lv_font_montserrat_20, 0);
        lv_obj_center(time_label_);
    }

    lv_obj_remove_flag(focus_container_, LV_OBJ_FLAG_HIDDEN);
    
    int value = (remaining_seconds * 100) / total_seconds;
    lv_arc_set_value(arc_timer_, 100 - value);

    char buf[16];
    snprintf(buf, sizeof(buf), "%02d:%02d", remaining_seconds / 60, remaining_seconds % 60);
    lv_label_set_text(time_label_, buf);
}
