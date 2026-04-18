import st7735
from .base import Page
import time
from .layout import SlidingWindowLayout
from .render_utils import draw_mixed_text

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
        self.scroll_y = 0 # Vertical pixel offset for scrolling
        self.VIEWPORT_HEIGHT = 115 # From LIST_START_Y to Footer
        
        # Style
        self.COLOR_BG = 0x0000
        self.COLOR_TEXT = 0xFFFF
        self.COLOR_DONE = 0x07E0 # Green
        self.COLOR_DIM = 0x8410  # Grey
        self.COLOR_SEL = 0x001F  # Dark Blue
        
        self.LINE_HEIGHT = 18
        self.LIST_START_Y = 30
        self.TEXT_X = 30
        self.TEXT_WIDTH = 90
        
    def on_enter(self, **kwargs):
        # Prepare layout and heights for all tasks
        for task in self.tasks:
            layout = SlidingWindowLayout(task['text'], max_width=self.TEXT_WIDTH, line_height=self.LINE_HEIGHT)
            # Pre-calculate all lines (AOT)
            layout.update_window(0, window_size=10) # Assume max 10 lines per task for kid's focus
            task['layout'] = layout
            task['line_count'] = len(layout.line_window)
            task['height'] = task['line_count'] * self.LINE_HEIGHT + 4 # Padding
            
        super().on_enter(**kwargs)

    def draw(self):
        fb = self.app.fb
        fb.fill(self.COLOR_BG)
        
        # Header
        self.draw_status_bar("My Missions")
        
        # List Items - Dynamic Drawing
        current_y = self.LIST_START_Y - self.scroll_y
        
        for i, task in enumerate(self.tasks):
            h = task['height']
            
            # Visibility check
            if current_y + h < self.LIST_START_Y:
                current_y += h
                continue
            if current_y > 140: # Near footer
                break
                
            # Highlight Selection
            if i == self.selection:
                # Selection box matches multi-line height
                fb.fill_rect(0, current_y, 128, h, self.COLOR_SEL)
            
            # Draw Checkbox (centered vertically in its item)
            box_y = current_y + (h // 2) - 5
            if task['done']:
                fb.fill_rect(10, box_y, 10, 10, self.COLOR_DONE)
                fb.text("v", 12, box_y+1, 0x0000)
            else:
                fb.rect(10, box_y, 10, 10, self.COLOR_TEXT)
                
            # Draw Text (Multi-line)
            text_color = self.COLOR_DIM if task['done'] else self.COLOR_TEXT
            layout = task['layout']
            
            for line_idx in range(task['line_count']):
                line_text = layout.get_line_text(line_idx)
                line_y = current_y + 2 + (line_idx * self.LINE_HEIGHT)
                draw_mixed_text(fb, line_text, self.TEXT_X, line_y, text_color)

            current_y += h

        # Simple Scroll indicator (Optional)
        fb.fill_rect(126, self.LIST_START_Y, 2, 110, self.COLOR_DIM)
        # Position estimate for scrollbar
        total_h = sum(t['height'] for t in self.tasks)
        if total_h > self.VIEWPORT_HEIGHT:
            sb_h = max(10, int(110 * (self.VIEWPORT_HEIGHT / total_h)))
            sb_y = self.LIST_START_Y + int(110 * (self.scroll_y / total_h))
            fb.fill_rect(126, sb_y, 2, sb_h, self.COLOR_DONE)

        # Footer
        fb.text("OK:Toggle", 5, 145, 0x8410)

    def on_key(self, key, event='PRESS'):
        if key == 'UP':
            if self.selection > 0:
                self.selection -= 1
                self.ensure_visible()
                self.app.draw_screen()
                
        elif key == 'DOWN':
            if self.selection < len(self.tasks) - 1:
                self.selection += 1
                self.ensure_visible()
                self.app.draw_screen()
                
        elif key == 'OK':
            task = self.tasks[self.selection]
            task['done'] = not task['done']
            
            if task['done']:
                self.app.device.vibrate(50)
                self.app.device.set_rgb_color(0, 50, 0)
                time.sleep(0.1)
                self.app.device.clear_rgb()
                
            self.app.draw_screen()
            
        elif key == 'BACK':
            self.app.switch_to('menu')
            
    def ensure_visible(self):
        """Adjust scroll_y to keep selection in view"""
        # Calculate Y position of selected task relative to start of list
        top_y = 0
        for i in range(self.selection):
            top_y += self.tasks[i]['height']
        
        bot_y = top_y + self.tasks[self.selection]['height']
        
        # If selection is above viewport
        if top_y < self.scroll_y:
            self.scroll_y = top_y
        # If selection is below viewport
        elif bot_y > self.scroll_y + self.VIEWPORT_HEIGHT:
            self.scroll_y = bot_y - self.VIEWPORT_HEIGHT
