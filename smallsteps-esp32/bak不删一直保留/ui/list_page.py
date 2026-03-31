import st7735
from .base import Page
import time

class ListPage(Page):
    def __init__(self, app):
        super().__init__(app)
        # Mock Data - Ideally this comes from a TaskManager or JSON file
        self.tasks = [
            {'id': 1, 'text': 'Read 10 pages', 'done': False},
            {'id': 2, 'text': 'Drink Water', 'done': False},
            {'id': 3, 'text': 'Tidy Desk', 'done': True},
            {'id': 4, 'text': 'Homework Math', 'done': False},
            {'id': 5, 'text': 'Draw Picture', 'done': False},
            {'id': 6, 'text': 'Feed Cat', 'done': False},
        ]
        self.selection = 0
        self.scroll_offset = 0
        self.VISIBLE_ITEMS = 5
        
        # Style
        self.COLOR_BG = 0x0000
        self.COLOR_TEXT = 0xFFFF
        self.COLOR_DONE = 0x07E0 # Green
        self.COLOR_DIM = 0x8410  # Grey
        self.COLOR_SEL = 0x001F  # Dark Blue
        
        self.ITEM_HEIGHT = 20
        self.LIST_START_Y = 30

    def draw(self):
        fb = self.app.fb
        fb.fill(self.COLOR_BG)
        
        # Header
        self.draw_status_bar("My Missions")
        
        # List Items
        for i in range(self.VISIBLE_ITEMS):
            task_idx = self.scroll_offset + i
            if task_idx >= len(self.tasks):
                break
                
            task = self.tasks[task_idx]
            y_pos = self.LIST_START_Y + i * self.ITEM_HEIGHT
            
            # Highlight Selection
            if task_idx == self.selection:
                fb.fill_rect(0, y_pos, 128, self.ITEM_HEIGHT, self.COLOR_SEL)
            
            # Draw Checkbox
            box_color = self.COLOR_TEXT
            if task['done']:
                box_color = self.COLOR_DONE
                fb.fill_rect(10, y_pos+4, 10, 10, self.COLOR_DONE)
                # Checkmark simulation (or just filled box)
                fb.text("v", 12, y_pos+5, 0x0000)
            else:
                fb.rect(10, y_pos+4, 10, 10, self.COLOR_TEXT)
                
            # Draw Text
            text_color = self.COLOR_TEXT
            if task['done']:
                text_color = self.COLOR_DIM
                
            # Truncate text if too long
            display_text = task['text']
            if len(display_text) > 12:
                display_text = display_text[:11] + "."
                
            fb.text(display_text, 30, y_pos+6, text_color)

        # Scrollbar (Optional simpler version)
        if len(self.tasks) > self.VISIBLE_ITEMS:
            sb_h = int(100 * (self.VISIBLE_ITEMS / len(self.tasks)))
            sb_y = self.LIST_START_Y + int(100 * (self.scroll_offset / len(self.tasks)))
            fb.line(126, self.LIST_START_Y, 126, self.LIST_START_Y+100, self.COLOR_DIM)
            fb.line(126, sb_y, 126, sb_y+sb_h, self.COLOR_DONE)

        # Footer
        fb.text("OK:Toggle", 5, 145, 0x8410)

    def on_key(self, key, event='PRESS'):
        if key == 'UP':
            if self.selection > 0:
                self.selection -= 1
                # Scroll Up
                if self.selection < self.scroll_offset:
                    self.scroll_offset = self.selection
                self.app.draw_screen()
                
        elif key == 'DOWN':
            if self.selection < len(self.tasks) - 1:
                self.selection += 1
                # Scroll Down
                if self.selection >= self.scroll_offset + self.VISIBLE_ITEMS:
                    self.scroll_offset = self.selection - self.VISIBLE_ITEMS + 1
                self.app.draw_screen()
                
        elif key == 'OK':
            task = self.tasks[self.selection]
            task['done'] = not task['done']
            
            # Feedback
            if task['done']:
                self.app.device.vibrate(50)
                self.app.device.set_rgb_color(0, 50, 0) # Flash Green
                time.sleep(0.1)
                self.app.device.clear_rgb()
                
            self.app.draw_screen()
            
        elif key == 'BACK':
            self.app.switch_to('menu')
