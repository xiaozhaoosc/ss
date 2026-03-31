from machine import Pin
import time

# ========================================
# 震动马达调试脚本 (多维度测试)
# ========================================

print("=== Motor Debug Test Suite ===\n")

# 测试 1: 验证 GPIO 输出电压
print("[Test 1] GPIO Output Verification")
print("Action: Setting GPIO 6 to HIGH")
print("Please measure voltage between GPIO 6 and GND with multimeter")
motor = Pin(6, Pin.OUT)
motor.value(1)
print("GPIO 6 is now HIGH - Expected: ~3.3V")
input("Press Enter after measuring voltage...")
motor.value(0)
print("GPIO 6 is now LOW - Expected: ~0V\n")

# 测试 2: 快速脉冲测试（检测马达是否需要 PWM）
print("[Test 2] Rapid Pulse Test (Simulating PWM)")
print("Some motors need PWM signal instead of constant HIGH")
motor.value(0)
time.sleep(1)
for i in range(50):  # 5 秒，100Hz 频率
    motor.value(1)
    time.sleep(0.005)
    motor.value(0)
    time.sleep(0.005)
print("Pulse test completed. Did you feel vibration?\n")

# 测试 3: 长时间高电平（原测试）
print("[Test 3] Sustained HIGH (10 seconds)")
print("Holding GPIO 6 HIGH for 10 seconds...")
motor.value(1)
time.sleep(10)
motor.value(0)
print("Done.\n")

# 测试 4: 间歇性脉冲（更明显）
print("[Test 4] Intermittent Pulses")
for i in range(5):
    print("Pulse " + str(i+1) + "/5")
    motor.value(1)
    time.sleep(0.5)
    motor.value(0)
    time.sleep(0.5)
print("Intermittent test completed.\n")

print("=== Diagnostic Checklist ===")
print("1. Did Test 1 show ~3.3V? (Verify GPIO works)")
print("2. Did Test 2 cause vibration? (Motor may need PWM)")
print("3. Did Test 3 cause vibration? (Motor works with DC)")
print("4. Did Test 4 cause vibration? (Most obvious test)")
print("\nIf ALL tests failed:")
print("  - Check if motor module has an ENABLE pin")
print("  - Try connecting IN to 5V directly (bypass ESP32)")
print("  - Motor module may be faulty")
