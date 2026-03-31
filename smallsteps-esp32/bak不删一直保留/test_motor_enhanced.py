from machine import Pin, PWM
import time

# ========================================
# 震动马达强驱动测试
# ========================================
# 针对 5V 逻辑模块的增强驱动尝试
# ========================================

print("=== Enhanced Drive Test for 5V Logic Module ===\n")

# 测试 1: 标准 GPIO 输出（已知可能不够）
print("[Test 1] Standard GPIO HIGH (3.3V)")
motor = Pin(6, Pin.OUT)
motor.value(1)
print("GPIO 6 = HIGH, holding for 5 seconds...")
time.sleep(5)
motor.value(0)
print("Done. Did you feel vibration?\n")
time.sleep(2)

# 测试 2: 使用 PWM 100% 占空比（可能提供更强驱动）
print("[Test 2] PWM 100% Duty Cycle")
motor_pwm = PWM(Pin(6), freq=1000, duty=1023)
print("PWM at 100%, holding for 5 seconds...")
time.sleep(5)
motor_pwm.deinit()
print("Done. Did you feel vibration?\n")
time.sleep(2)

# 测试 3: 高频 PWM（某些 MOS 管对频率敏感）
print("[Test 3] High Frequency PWM (10kHz)")
motor_pwm = PWM(Pin(6), freq=10000, duty=1023)
print("PWM at 10kHz, holding for 5 seconds...")
time.sleep(5)
motor_pwm.deinit()
print("Done. Did you feel vibration?\n")
time.sleep(2)

# 测试 4: 快速脉冲（可能累积效应）
print("[Test 4] Rapid Pulsing")
motor = Pin(6, Pin.OUT)
for i in range(100):
    motor.value(1)
    time.sleep(0.02)
    motor.value(0)
    time.sleep(0.02)
print("Done. Did you feel vibration?\n")

print("=== Test Results Analysis ===")
print("If ALL tests failed:")
print("  -> ESP32's 3.3V is insufficient for this 5V logic module")
print("  -> Solution: Add level shifter (3.3V to 5V)")
print("\nIf ANY test succeeded:")
print("  -> Note which test worked for future reference")
print("\nRecommended Hardware Fix:")
print("  1. Use TXS0108E level shifter module")
print("  2. Or use NPN transistor (2N2222/S8050) as switch")
print("  3. Or replace with 3.3V compatible motor module")
