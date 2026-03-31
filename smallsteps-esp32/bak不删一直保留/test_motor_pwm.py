from machine import Pin, PWM
import time

# ========================================
# 震动马达 PWM 测试脚本
# ========================================
# 适用于需要 PWM 信号的马达驱动模块
# ========================================

print("=== Motor PWM Test ===\n")

# 创建 PWM 对象（频率 1000Hz，占空比 50%）
motor_pwm = PWM(Pin(6), freq=1000, duty=512)  # duty: 0-1023

print("Test 1: 50% Duty Cycle (5 seconds)")
motor_pwm.duty(512)
time.sleep(5)
motor_pwm.duty(0)
print("Done.\n")

print("Test 2: 100% Duty Cycle (5 seconds)")
motor_pwm.duty(1023)
time.sleep(5)
motor_pwm.duty(0)
print("Done.\n")

print("Test 3: Ramping Duty Cycle")
for duty in range(0, 1024, 100):
    print("Duty: " + str(duty))
    motor_pwm.duty(duty)
    time.sleep(0.5)
motor_pwm.duty(0)
print("Done.\n")

print("Test 4: Pulsing Effect")
for i in range(10):
    motor_pwm.duty(1023)
    time.sleep(0.2)
    motor_pwm.duty(0)
    time.sleep(0.2)
print("Done.\n")

# 清理
motor_pwm.deinit()
print("PWM test completed.")
print("If vibration occurred, your motor needs PWM signal.")
