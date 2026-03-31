from machine import Pin
import time

# ========================================
# 震动马达测试脚本 (5V 电源板版本)
# ========================================
# 接线说明:
#   - 马达 IN  -> ESP32 GPIO 6
#   - 马达 VCC -> 5V 电源板输出
#   - 马达 GND -> 共地 (ESP32 GND)
# ========================================

def test_motor_final(pin_num):
    print("\n--- Testing GPIO " + str(pin_num) + " (5V Power Mode) ---")
    try:
        motor = Pin(pin_num, Pin.OUT)
        # 持续 5 秒，方便观察震动效果
        print("Holding GPIO " + str(pin_num) + " HIGH for 5 seconds...")
        motor.value(1)
        time.sleep(5)
        motor.value(0)
        print("Done.")
    except Exception as e:
        print("Error on GPIO " + str(pin_num) + ": " + str(e))

print("=== Haptic Motor Test (5V Power Board) ===")
print("Wiring:")
print("  IN  -> GPIO 6")
print("  VCC -> 5V Power Board")
print("  GND -> Common Ground")
print("")

test_motor_final(6)

print("\nTest completed. Check for vibration during the 5-second pulse.")
