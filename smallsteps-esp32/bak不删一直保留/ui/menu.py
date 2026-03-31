import st7735
from .base import Page

class MenuPage(Page):
    def __init__(self, app):
        super().__init__(app)
        self.items = [
            {"label": "Focus Mode", "action": "focus"},
            {"label": "To-Do List", "action": "list"},
            {"label": "Hardware Test", "action": "test"}, # Placeholder for now
            {"label": "Settings", "action": "settings"}   # Placeholder
        ]
        self.selection = 0
        
        self.COLOR_BG = 0x0000
        self.COLOR_SEL = 0x07E0 # Green
        self.COLOR_TEXT = 0xFFFF
        
    def draw(self):
        fb = self.app.fb
        fb.fill(self.COLOR_BG)
        
        # Header
        self.draw_status_bar("Small Steps")
        
        # List
        y_start = 40
        for i, item in enumerate(self.items):
            color = self.COLOR_TEXT
            prefix = "  "
            if i == self.selection:
                color = st7735.YELLOW
                prefix = "> "
                # Highlight bar
                fb.rect(5, y_start + i*20 - 4, 118, 18, self.COLOR_SEL)
                
            fb.text(prefix + item["label"], 10, y_start + i*20, color)
            
        # Footer
        fb.text("OK:Select", 5, 145, 0x8410)

    def on_key(self, key, event='PRESS'):
        if key == 'UP':
            self.selection = (self.selection - 1) % len(self.items)
            self.app.draw_screen()
        elif key == 'DOWN':
            self.selection = (self.selection + 1) % len(self.items)
            self.app.draw_screen()
        elif key == 'OK':
            item = self.items[self.selection]
            self.handle_action(item["action"])
            
    def handle_action(self, action):
        if action == "focus":
            self.app.switch_to("focus")
        elif action == "list":
            self.app.switch_to("list")
        elif action == "test":
            print("Test Mode selected (Not implemented in UI yet)")
            # self.app.switch_to("test")
        elif action == "settings":
            print("Settings selected")
