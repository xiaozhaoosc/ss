"""
Small Steps (小步) - Hardware Verification Script
Run this script to verify:
1. ST7735 Screen (Colors, Text)
2. Buttons (Interactivity)
3. LED Ring (Basic Cycle)
Config:
    See `readme_test.md` for wiring details and troubleshooting.
    See `device.py` for pin definitions.
"""

from device import DeviceManager, HardwareConfig
import st7735
import time
import framebuf

print("=== Starting Hardware Verification ===")

# 1. Initialize Device Wrapper
# This handles SPI/Pin setup automatically
dev = DeviceManager()

# 2. Test Screen Colors
print("Testing Screen Colors...")
colors = [
    (st7735.RED, "RED"),
    (st7735.GREEN, "GREEN"),
    (st7735.BLUE, "BLUE"),
    (st7735.WHITE, "WHITE"),
    (st7735.BLACK, "BLACK")
]

for color, name in colors:
    dev.tft.fill(color)
    time.sleep(0.5)

# 3. Test Framebuffer Text
print("Testing Text Rendering...")
WIDTH = 128
HEIGHT = 160
buffer = bytearray(WIDTH * HEIGHT * 2)
fb = framebuf.FrameBuffer(buffer, WIDTH, HEIGHT, framebuf.RGB565)

def update_display():
    dev.tft.set_window(0, 0, WIDTH-1, HEIGHT-1)
    dev.tft.dc(1)
    dev.tft.cs(0)
    dev.tft.spi.write(buffer)
    dev.tft.cs(1)

fb.fill(0x0000)
fb.rect(0, 0, 128, 160, st7735.WHITE)
fb.text("Hardware Test", 10, 10, st7735.YELLOW)
fb.hline(0, 25, 128, st7735.RED)

fb.text("Press Buttons:", 10, 40, st7735.WHITE)
fb.text("UP   : GPIO 4", 10, 60, st7735.CYAN)
fb.text("DOWN : GPIO 5", 10, 75, st7735.CYAN)
fb.text("OK   : GPIO 6", 10, 90, st7735.CYAN)
fb.text("BACK : GPIO 7", 10, 105, st7735.CYAN)

update_display()

# 4. Interactive Button Test
print("Entering Button Loop (Press Ctrl+C to stop)...")
last_state = {}

while True:
    # Check buttons (Active Low)
    status_changed = False
    
    if dev.btn_up.value() == 0:
        print("Button: UP")
        fb.fill_rect(100, 60, 10, 10, st7735.GREEN)
        status_changed = True
    else:
        fb.fill_rect(100, 60, 10, 10, st7735.BLACK)
        
    if dev.btn_down.value() == 0:
        print("Button: DOWN")
        fb.fill_rect(100, 75, 10, 10, st7735.GREEN)
        status_changed = True
    else:
        fb.fill_rect(100, 75, 10, 10, st7735.BLACK)

    if dev.btn_ok.value() == 0:
        print("Button: OK")
        fb.fill_rect(100, 90, 10, 10, st7735.GREEN)
        status_changed = True
    else:
        fb.fill_rect(100, 90, 10, 10, st7735.BLACK)

    if dev.btn_back.value() == 0:
        print("Button: BACK")
        fb.fill_rect(100, 105, 10, 10, st7735.GREEN)
        status_changed = True
    else:
        fb.fill_rect(100, 105, 10, 10, st7735.BLACK)
    
    if status_changed:
        update_display()
        time.sleep(0.1) # Simple debounce
