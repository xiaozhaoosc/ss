from machine import Pin
import time

# ========================================
# 震动马达封装类（支持三极管反向逻辑）
# ========================================

class HapticMotor:
    """
    震动马达控制类
    
    支持两种硬件配置：
    1. 直连模式：GPIO 直接连接马达 IN（需要 5V 逻辑）
    2. 三极管模式：通过 NPN 三极管驱动（反向逻辑）
    """
    
    def __init__(self, pin_num, inverted=True):
        """
        初始化马达控制器
        
        参数：
            pin_num: GPIO 引脚号
            inverted: 是否使用反向逻辑（三极管模式为 True）
        """
        self.motor = Pin(pin_num, Pin.OUT)
        self.inverted = inverted
        self.stop()  # 初始化为停止状态
    
    def vibrate(self):
        """开始震动"""
        if self.inverted:
            self.motor.value(0)  # 三极管模式：LOW = 震动
        else:
            self.motor.value(1)  # 直连模式：HIGH = 震动
    
    def stop(self):
        """停止震动"""
        if self.inverted:
            self.motor.value(1)  # 三极管模式：HIGH = 停止
        else:
            self.motor.value(0)  # 直连模式：LOW = 停止
    
    def pulse(self, duration_ms=200):
        """
        单次脉冲震动
        
        参数：
            duration_ms: 震动持续时间（毫秒）
        """
        self.vibrate()
        time.sleep_ms(duration_ms)
        self.stop()
    
    def pattern(self, pattern_list):
        """
        按照模式震动
        
        参数：
            pattern_list: 震动模式列表，格式 [(震动时长ms, 停止时长ms), ...]
        
        示例：
            motor.pattern([(200, 100), (200, 100), (500, 0)])
            # 短震-停-短震-停-长震
        """
        for vibrate_ms, pause_ms in pattern_list:
            if vibrate_ms > 0:
                self.vibrate()
                time.sleep_ms(vibrate_ms)
                self.stop()
            if pause_ms > 0:
                time.sleep_ms(pause_ms)


# ========================================
# 使用示例
# ========================================

if __name__ == "__main__":
    print("=== Haptic Motor Class Demo ===\n")
    
    # 初始化马达（GPIO 6，三极管模式）
    motor = HapticMotor(6, inverted=True)
    
    # 测试 1: 基本震动
    print("[Test 1] Basic Vibration (2 seconds)")
    motor.vibrate()
    time.sleep(2)
    motor.stop()
    time.sleep(1)
    
    # 测试 2: 脉冲震动
    print("[Test 2] Pulse Vibration (200ms x 3)")
    for i in range(3):
        motor.pulse(200)
        time.sleep(300)
    time.sleep(1)
    
    # 测试 3: 模式震动（SOS 信号）
    print("[Test 3] SOS Pattern")
    sos_pattern = [
        # S (短-短-短)
        (200, 100), (200, 100), (200, 300),
        # O (长-长-长)
        (500, 100), (500, 100), (500, 300),
        # S (短-短-短)
        (200, 100), (200, 100), (200, 0)
    ]
    motor.pattern(sos_pattern)
    
    print("\nDemo completed!")
