# -*- coding: utf-8 -*-
import st7735
from .base import Page
import time
import math

class VoiceHolePage(Page):
    def __init__(self, app):
        super().__init__(app)
        self.title = "语音树洞"
        self.is_recording = False
        self.recording_progress = 0
        self.MAX_DURATION = 10 # 10 seconds for secrets
        self.last_filename = "wavs/secret.wav"
        
        # Style
        self.COLOR_HOLE = 0x001F # Deep Blue
        self.COLOR_REC = 0xF800  # Red
        
    def draw(self):
        fb = self.app.fb
        fb.fill(0x0000) # Black
        
        # Header
        self.draw_status_bar(self.title)
        
        # Draw "Tree Hole" (a big dark circle/rect)
        centerX, centerY = 64, 80
        radius = 40
        fb.fill_rect(centerX - radius, centerY - radius, radius*2, radius*2, self.COLOR_HOLE)
        fb.rect(centerX - radius - 2, centerY - radius - 2, radius*2 + 4, radius*2 + 4, 0xFFFF)
        
        if self.is_recording:
            # Pulsing Red dot
            if (time.ticks_ms() // 500) % 2 == 0:
                fb.fill_rect( centerX - 5, centerY - 50, 10, 10, self.COLOR_REC)
            fb.text("正在倾听...", 35, centerY - 5, 0xFFFF)
            
            # Progress bar
            bar_w = int(100 * (self.recording_progress / (self.MAX_DURATION * 1000)))
            fb.fill_rect(14, 130, bar_w, 4, 0x07E0) # Green
        else:
            fb.text("在这里说出", 30, centerY - 10, 0xFFFF)
            fb.text("你的秘密...", 30, centerY + 5, 0xFFFF)
            
        # Helper text
        fb.text("OK:录音  UP:回听", 5, 145, 0x8410)

    def recording_update(self, elapsed_ms):
        self.recording_progress = elapsed_ms
        # LED Breathing Effect
        # Cycle every 2 seconds (2000ms)
        angle = (elapsed_ms % 2000) / 2000 * 2 * math.pi
        brightness = (math.sin(angle) + 1) / 2 # 0.0 to 1.0
        self.device.set_led_ring((0, 100, 100), brightness) # Cyan breath
        
        # We don't call app.draw_screen() here to avoid blocking I2S timing too much,
        # but we can update the progress bar occasionally.
        if elapsed_ms % 500 < 50:
             self.app.draw_screen()

    def on_key(self, key, event='PRESS'):
        if self.is_recording:
            # Any key stops or just wait for timer?
            # Standard: let record_audio finish its loop
            return

        if key == 'OK':
            self.is_recording = True
            self.recording_progress = 0
            self.app.draw_screen()
            
            # Feedback
            self.device.vibrate(100)
            
            # Start Recording (Blocking in this impl, but with callback for animation)
            success = self.device.record_audio(
                filename=self.last_filename, 
                duration_sec=self.MAX_DURATION,
                update_cb=self.recording_update
            )
            
            self.is_recording = False
            self.device.clear_rgb()
            
            if success:
                self.device.set_rgb_color(0, 100, 0) # Green flash
                time.sleep(0.2)
                self.device.clear_rgb()
            
            self.app.draw_screen()
            
        elif key == 'UP':
            # Playback logic
            print("Playback: " + self.last_filename)
            # For now, via DFPlayer if supported, or just mock feedback
            self.device.vibrate(50)
            # In a real build, we'd use I2S Out to play the wav
            
        elif key == 'BACK':
            self.app.switch_to('menu')
