from ui.base import Page
import st7735
import time

class HomePage(Page):
    """主菜单页面"""
    
    MENU_ITEMS = [
        {"id": "tasks", "text": "我的任务", "icon": "TASK"}, 
        {"id": "focus", "text": "专注模式", "icon": "FOCUS"},
        {"id": "settings", "text": "系统设置", "icon": "SET"},
        {"id": "test", "text": "硬件测试", "icon": "TEST"},
        {"id": "about", "text": "关于设备", "icon": "INFO"}
    ]
    
    def __init__(self, app):
        super().__init__(app)
        self.selected_index = 0
        self.last_update = 0
        
    def on_enter(self, **kwargs):
        print("[HomePage] Entered")
        self.app.device.set_led_status("idle")
    
    def draw(self):
        fb = self.app.fb
        fb.fill(0x0000) # Black background
        
        # 1. Status Bar
        self.draw_status_bar("小步 SmallSteps")
        
        # 2. Connection Status (Large Icon if offline)
        if hasattr(self.app, 'mqtt_connected') and not self.app.mqtt_connected:
            self._draw_status_msg(30, "离线模式")
        
        # 3. Menu List
        start_y = 50
        item_height = 20 # 调小高度以容纳更多项
        
        # 翻页逻辑（简单的视窗）
        # 暂时只显示 5 项，正好一屏
        
        for i, item in enumerate(self.MENU_ITEMS):
            y = start_y + i * item_height
            
            # Selection Highlight
            if i == self.selected_index:
                fb.fill_rect(5, y, 118, 18, 0x001F) # Blue Highlight
                color = st7735.WHITE
                prefix = "> "
            else:
                color = 0x8410 # Grey
                prefix = "  "
            
            # Text
            try:
                # 尝试绘制中文
                # 注意：draw_cn 会自动回退到 ASCII 如果字库中没有字
                # 我们已经补全了大部分字
                self.draw_cn(10, y + 2, item["text"], color)
                    
            except Exception as e:
                # Fallback to English/ASCII
                fb.text(item["text"], 10, y + 2, color)
    
    def _draw_status_msg(self, y, msg):
        self.draw_cn(40, y, msg, 0xF800) # Red
        
    def on_key(self, key, event='PRESS'):
        if key == 'UP':
            self.selected_index = (self.selected_index - 1) % len(self.MENU_ITEMS)
            self.app.draw_screen() # Trigger redraw
            self.app.device.play_sound(5) # Click sound
            
        elif key == 'DOWN':
            self.selected_index = (self.selected_index + 1) % len(self.MENU_ITEMS)
            self.app.draw_screen()
            self.app.device.play_sound(5)
            
        elif key == 'OK':
            print(f"[Menu] Selected: {self.MENU_ITEMS[self.selected_index]['id']}")
            self.app.device.play_sound(5)
            
            selected_id = self.MENU_ITEMS[self.selected_index]['id']
            if selected_id == "tasks":
                self.app.switch_to("tasks")
            elif selected_id == "focus":
                self.app.switch_to("focus")
            elif selected_id == "settings":
                self.app.switch_to("settings")
            elif selected_id == "test":
                print("Test page not implemented")
            elif selected_id == "about":
                print("About page not implemented")
