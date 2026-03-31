import st7735
from .base import Page

class SettingsPage(Page):
    def __init__(self, app):
        super().__init__(app)
        self.items = [
            {"label": "音量: 80%", "action": "vol"},
            {"label": "亮度: 100", "action": "bri"},
            {"label": "WiFi: TzdG", "action": "wifi"},
            {"label": "关于设备", "action": "about"}
        ]
        self.selection = 0
        self.COLOR_BG = 0x0000
        self.COLOR_SEL = 0x001F
        self.COLOR_TEXT = 0xFFFF

    def draw(self):
        fb = self.app.fb
        fb.fill(self.COLOR_BG)
        self.draw_status_bar("系统设置")
        
        y_start = 30
        for i, item in enumerate(self.items):
            color = self.COLOR_TEXT
            if i == self.selection:
                fb.fill_rect(0, y_start + i*20 - 2, 128, 18, self.COLOR_SEL)
                try:
                    self.draw_cn(5, y_start + i*20 - 2, "> " + item["label"], color)
                except:
                    fb.text("> " + item["label"], 5, y_start + i*20, color)
            else:
                try:
                    self.draw_cn(5, y_start + i*20 - 2, "  " + item["label"], color)
                except:
                    fb.text("  " + item["label"], 5, y_start + i*20, color)
                
        fb.text("OK:修改 Back:返回", 5, 145, 0x8410)

    def on_key(self, key, event='PRESS'):
        if key == 'UP':
            self.selection = (self.selection - 1) % len(self.items)
            self.app.draw_screen()
        elif key == 'DOWN':
            self.selection = (self.selection + 1) % len(self.items)
            self.app.draw_screen()
        elif key == 'BACK':
            self.app.switch_to('home')
        elif key == 'OK':
            # Placeholder actions
            item = self.items[self.selection]
            print(f"[Settings] Selected {item['label']}")
            self.app.device.play_sound(5)
