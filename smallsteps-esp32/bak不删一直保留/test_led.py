from machine import Pin
import neopixel
import time

def test_pin(pin_num, pixel_count=12):
    print(f"--- Testing GPIO {pin_num} ---")
    try:
        pin = Pin(pin_num, Pin.OUT)
        np = neopixel.NeoPixel(pin, pixel_count)
        
        colors = [(255, 0, 0), (0, 255, 0), (0, 0, 255)] # R, G, B
        color_names = ["RED", "GREEN", "BLUE"]
        
        for color, name in zip(colors, color_names):
            print(f"Setting color: {name}")
            for i in range(pixel_count):
                np[i] = color
            np.write()
            time.sleep(1)
            
        # Clear
        for i in range(pixel_count):
            np[i] = (0, 0, 0)
        np.write()
        print(f"GPIO {pin_num} test finished.\n")
    except Exception as e:
        print(f"Failed to test GPIO {pin_num}: {e}\n")

# 测试列表：
# 38: 用户当前使用的引脚（可能与 Octal SPI 冲突）
# 15: 备选 1 (通用 IO)
# 8:  备选 2 (通用 IO)
# 16: 备选 3 (通用 IO)

test_pins = [38, 15, 8, 16]

print("Starting RGB LED Pin Discovery Test...")
print("Please watch the LED ring and note which GPIO lights it up.\n")

for p in test_pins:
    test_pin(p)

print("Test script execution completed.")
