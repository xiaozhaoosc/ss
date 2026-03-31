import framebuf
import st7735
import time

class Page:
    def __init__(self, app):
        self.app = app
        self.device = app.device
        
    def on_enter(self, **kwargs):
        """Called when this page becomes active"""
        pass
        
    def on_exit(self):
        """Called when leaving this page"""
        pass
        
    def draw(self):
        """Render the page to the framebuffer"""
        pass
        
    def update(self):
        """Called every loop iteration (for animations etc)"""
        pass
        
    def on_key(self, key, event='PRESS'):
        """Handle key events. Key: UP, DOWN, OK, BACK"""
        pass

    def draw_status_bar(self, title):
        fb = self.app.fb
        # Background
        fb.fill_rect(0, 0, 128, 20, 0x001F) # Dark Blue
        
        # Title
        if title:
            fb.text(title, 5, 6, st7735.WHITE)
            
        # Time (Real from RTC +8 Timezone)
        # GMT+8 = 8 * 3600 = 28800 sec
        t = time.time() + 28800 
        tm = time.localtime(t) # (year, month, mday, hour, minute, second, weekday, yearday)
        time_str = "{:02}:{:02}".format(tm[3], tm[4]) # Hour:Minute
        fb.text(time_str, 85, 6, st7735.WHITE)
        
        # WiFi Icon
        wifi_color = 0x8410 # Grey
        if hasattr(self.device, 'wifi') and self.device.wifi.is_connected():
            wifi_color = 0x07E0 # Green
        fb.fill_rect(75, 8, 4, 4, wifi_color)
        
        # Battery Icon (Mock)
        fb.rect(118, 6, 8, 5, st7735.WHITE)
        fb.fill_rect(120, 7, 4, 3, 0x07E0) # Green fill

class App:
    def __init__(self, device_manager):
        self.device = device_manager
        self.pages = {}
        self.current_page = None
        self.running = True
        
        # Display Buffer (Global for the App)
        self.WIDTH = 128
        self.HEIGHT = 160
        self.buffer = bytearray(self.WIDTH * self.HEIGHT * 2)
        self.fb = framebuf.FrameBuffer(self.buffer, self.WIDTH, self.HEIGHT, framebuf.RGB565)
        
    def register_page(self, name, page_class):
        self.pages[name] = page_class(self)
        
    def switch_to(self, name, **kwargs):
        if self.current_page:
            self.current_page.on_exit()
        
        if name in self.pages:
            self.current_page = self.pages[name]
            self.current_page.on_enter(**kwargs)
            self.draw_screen()
        else:
            print(f"Page {name} not found")

    def draw_screen(self):
        if self.current_page:
            # Clear buffer (black) - Optional, page might want to partial update
            # self.fb.fill(0x0000) 
            self.current_page.draw()
            self.refresh_display()

    def refresh_display(self):
        self.device.tft.set_window(0, 0, self.WIDTH-1, self.HEIGHT-1)
        self.device.tft.dc(1)
        self.device.tft.cs(0)
        self.device.tft.spi.write(self.buffer)
        self.device.tft.cs(1)
        
    def run(self):
        print("App Started")
        
        while self.running:
            # Input Handling
            # Using simple polling for now, could be interrupt based later
            if self.device.btn_up.value() == 0:
                self.handle_input('UP')
            elif self.device.btn_down.value() == 0:
                self.handle_input('DOWN')
            elif self.device.btn_ok.value() == 0:
                self.handle_input('OK')
            elif self.device.btn_back.value() == 0:
                self.handle_input('BACK')
                
            if self.current_page:
                self.current_page.update()
                
            time.sleep(0.02) # Yield

    def handle_input(self, key):
        if self.current_page:
            self.current_page.on_key(key)
        
        # Simple Debounce
        time.sleep(0.2) 
