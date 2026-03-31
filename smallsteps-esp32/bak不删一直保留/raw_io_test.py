from machine import Pin
import time

# 待测试的引脚列表 (已经避开了 Octal S3 冲突引脚)
test_pins = {
    "GPIO 15 (RGB)": 15,
    "GPIO 16 (I2S DIN)": 16,
    "GPIO 8  (I2S BCLK)": 8,
    "GPIO 1  (Motor IN)": 1,
    "GPIO 21 (I2S LRC)": 21
}

def run_raw_test():
    print("=== Raw GPIO Signal Diagnostic ===")
    print("Testing each pin by toggling High/Low. Connect your LED ring's")
    print("DATA line to the pin being tested to verify signal.\n")
    
    for name, pin_num in test_pins.items():
        print(f"Testing {name}...")
        try:
            p = Pin(pin_num, Pin.OUT)
            # 快速闪烁 5 次
            for _ in range(5):
                p.value(1)
                time.sleep(0.2)
                p.value(0)
                time.sleep(0.2)
            print(f"Done with {name}.\n")
        except Exception as e:
            print(f"Error on {name}: {e}\n")
    
    print("All logic tests completed.")

run_raw_test()
