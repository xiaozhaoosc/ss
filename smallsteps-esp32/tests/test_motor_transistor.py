from machine import Pin
import time

# ========================================
# 震动马达三极管驱动测试（反向逻辑）
# ========================================
# 硬件配置：
#   ESP32 GPIO 6 → [1kΩ] → NPN 三极管 B (基极)
#   三极管 C (集电极) → 马达 IN
#   三极管 E (发射极) → GND
#   马达 VCC → 5V 电源板
#   马达 GND → 共地
# ========================================
# 逻辑说明：
#   GPIO = LOW  → 三极管截止 → IN 上拉到 5V → 马达震动
#   GPIO = HIGH → 三极管导通 → IN 拉到 GND  → 马达停止
# ========================================

print("=== Haptic Motor Transistor Drive Test ===\n")

motor = Pin(6, Pin.OUT)

# 测试 1: 反向逻辑验证
print("[Test 1] Reverse Logic Verification")
print("Setting GPIO 6 = LOW (Motor should VIBRATE)")
motor.value(0)  # 三极管截止，马达应该震动
time.sleep(3)
print("Motor should be vibrating now...\n")

print("Setting GPIO 6 = HIGH (Motor should STOP)")
motor.value(1)  # 三极管导通，马达应该停止
time.sleep(2)
print("Motor should have stopped.\n")

# 测试 2: 间歇震动
print("[Test 2] Intermittent Vibration (5 pulses)")
for i in range(5):
    print("Pulse " + str(i+1) + "/5")
    motor.value(0)  # 震动
    time.sleep(0.5)
    motor.value(1)  # 停止
    time.sleep(0.5)
print("Intermittent test completed.\n")

# 测试 3: 长时间震动
print("[Test 3] Sustained Vibration (5 seconds)")
motor.value(0)  # 震动
time.sleep(5)
motor.value(1)  # 停止
print("Sustained test completed.\n")

# 确保最后停止
motor.value(1)

print("=== Test Summary ===")
print("If vibration occurred:")
print("  -> Transistor circuit works correctly!")
print("  -> Remember: GPIO LOW = Vibrate, GPIO HIGH = Stop")
print("\nIf no vibration:")
print("  -> Check transistor connections")
print("  -> Verify transistor type (NPN, not PNP)")
print("  -> Measure voltage at motor IN pin")
