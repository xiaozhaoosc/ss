import time
import math
import st7735
from .base import Page

class FocusPage(Page):
    def __init__(self, app):
        super().__init__(app)
        self.total_minutes = 25
        self.start_time = 0
        self.paused = False
        self.pause_start = 0
        self.remaining_sec = 0
        self.is_running = False
        
        # Colors
        self.COLOR_BG = 0x0000 
        self.COLOR_BAR = 0x07E0 # Green
        self.COLOR_WARN = 0xF800 # Red
        self.COLOR_TEXT = 0xFFFF
        
    def on_enter(self, duration_mins=25):
        self.total_minutes = duration_mins
        self.start_time = time.ticks_ms()
        self.remaining_sec = self.total_minutes * 60
        self.is_running = True
        self.paused = False
        
        print(f"Focus Mode Started: {duration_mins} mins")
        # Play Start Sound (If available)
        if self.app.device.player:
            try:
                self.app.device.player.play(1) 
            except:
                pass
                
        self.app.device.vibrate(100)

    def on_exit(self):
        self.is_running = False
        self.app.device.clear_rgb()

    def update(self):
        if not self.is_running:
            return

        if self.paused:
            # Maybe blink light yellow?
            return

        # Calculate remaining time
        now = time.ticks_ms()
        elapsed_ms = time.ticks_diff(now, self.start_time)
        elapsed_sec = elapsed_ms // 1000
        self.remaining_sec = (self.total_minutes * 60) - elapsed_sec
        
        if self.remaining_sec <= 0:
            self.complete_task()
            return
            
        # Breathing Light
        # Period 4s (4000ms)
        cycle = 4000
        phase = elapsed_ms % cycle
        # Sine wave approximation 0.0 to 1.0 (actually triangle wave is easier)
        if phase < (cycle // 2):
            brightness = (phase / (cycle // 2)) 
        else:
            brightness = 1.0 - ((phase - (cycle // 2)) / (cycle // 2))
            
        # Color based on remaining time
        if self.remaining_sec < 300: # Last 5 mins
            r = int(255 * brightness)
            g = 0
            b = 0
        else: # Calm Blue/Green
            r = 0
            g = int(50 * brightness)
            b = int(200 * brightness)
            
        self.app.device.set_rgb_color(r, g, b)
        
        # Force redraw every second or so? 
        # Actually in App loop we call page.update(). 
        # We should request redraw only if UI changes significant
        # For progress bar, maybe every few seconds is enough, but for smooth feel...
        # Let's request redraw every 1s
        if elapsed_ms % 1000 < 50: 
            self.app.draw_screen()

    def draw(self):
        fb = self.app.fb
        fb.fill(self.COLOR_BG)
        
        # Draw "Energy Bar" (Vertical)
        # Max Height = 120px (leaving some space for header/footer)
        MAX_H = 120
        BAR_W = 60
        BAR_X = (128 - BAR_W) // 2
        BAR_Y = 20
        
        progress = self.remaining_sec / (self.total_minutes * 60)
        current_h = int(MAX_H * progress)
        
        # Color based on progress
        color = self.COLOR_BAR
        if self.remaining_sec < 300:
            color = self.COLOR_WARN
            
        # Draw Container
        fb.rect(BAR_X-2, BAR_Y-2, BAR_W+4, MAX_H+4, st7735.WHITE)
        
        # Draw Fill
        # Fill from bottom up
        fill_y = BAR_Y + (MAX_H - current_h)
        fb.fill_rect(BAR_X, fill_y, BAR_W, current_h, color)
        
        # Text Info
        # Don't show seconds, just show "Focus" or approximate msg
        msg = "Focusing..."
        if self.paused:
            msg = "RESUME?"
            
        fb.text(msg, (128 - len(msg)*8)//2, 5, st7735.WHITE)
        
        # Instructions
        fb.text("OK:Pause", 5, 145, 0x8410)
        
    def complete_task(self):
        self.is_running = False
        self.app.device.set_rgb_color(0, 255, 0) # Green
        self.app.device.vibrate(500)
        # Transition to Success Page? For now just exit
        print("Task Complete!")
        # Ideally switch to a ResultPage
        self.app.switch_to('menu') # Back to menu for now

    def on_key(self, key, event='PRESS'):
        if key == 'BACK':
            # Confirm exit?
            self.app.switch_to('menu')
        elif key == 'OK':
            self.paused = not self.paused
            if self.paused:
                self.pause_start = time.ticks_ms()
                self.app.device.set_rgb_color(50, 50, 0) # Dim Yellow
            else:
                # Adjust start time to account for pause duration
                pause_duration = time.ticks_diff(time.ticks_ms(), self.pause_start)
                self.start_time = time.ticks_add(self.start_time, pause_duration)
            self.app.draw_screen()
