# -*- coding: utf-8 -*-
import st7735
from .base import Page
from .layout import SlidingWindowLayout
from .render_utils import draw_mixed_text
import gc

class StoryPage(Page):
    def __init__(self, app):
        super().__init__(app)
        self.title = "阅读小故事"
        
        # ADHD-friendly story using available Chinese chars + English
        # "小步开始了专注模式。整理书桌，完成数学作业。阅读书页，喝杯水。任务已完成，成功！"
        self.story_text = (
            "小步的专注任务\n\n"
            "小步开始了专注模式。\n"
            "Step 1: 整理书桌。\n"
            "Step 2: 完成数学作业。\n"
            "Step 3: 阅读书页。\n"
            "Step 4: 喝杯水。\n\n"
            "任务已完成，成功！\n"
            "小步在大步走，\n"
            "向着成功！\n\n"
            "Keep Going! 你很棒！\n"
            "-- Small Steps --"
        )
        
        self.layout = SlidingWindowLayout(self.story_text, max_width=118)
        self.scroll_line = 0
        self.max_display_lines = 6 # (160 - 30 header - 20 footer) // 18
        
        # Initial Window
        self.layout.update_window(0)
        
    def on_enter(self, **kwargs):
        self.scroll_line = 0
        self.layout.update_window(0)
        self.app.draw_screen()
        
    def draw(self):
        fb = self.app.fb
        fb.fill(0x0000) # Black
        
        # Header
        self.draw_status_bar(self.title)
        
        # Render lines from window
        start_y = 30
        line_h = 18
        
        for i in range(self.max_display_lines):
            line_idx = self.scroll_line + i
            text = self.layout.get_line_text(line_idx)
            if text:
                draw_mixed_text(fb, text, 5, start_y + i * line_h, 0xFFFF)
            else:
                break
                
        # Footer / Progress
        progress = "进度: {:d}%".format(min(100, (self.scroll_line * 10))) # Fake progress for demo
        fb.fill_rect(0, 145, 128, 15, 0x001F)
        fb.text(progress, 35, 148, 0xFFFF)
        
    def on_key(self, key, event='PRESS'):
        if key == 'UP':
            if self.scroll_line > 0:
                self.scroll_line -= 1
                # Sliding Window check (trigger reload if near edge)
                if self.scroll_line < self.layout.current_window_start_line + 2:
                    new_start = max(0, self.scroll_line - 10)
                    self.layout.update_window(new_start)
                self.app.draw_screen()
                
        elif key == 'DOWN':
            # Simplified "does next line exist" check
            if self.layout.get_line_text(self.scroll_line + 1):
                self.scroll_line += 1
                # Sliding Window check
                if self.scroll_line > self.layout.current_window_start_line + 20:
                    self.layout.update_window(self.scroll_line - 5)
                self.app.draw_screen()
                
        elif key == 'BACK':
            self.app.switch_to('menu')
            
        elif key == 'OK':
            # Toggle some secret ADHD encouragement?
            self.device.vibrate(50)
            self.device.set_rgb_color(0, 50, 50) # Cyan 
            import time
            time.sleep(0.1)
            self.device.clear_rgb()
