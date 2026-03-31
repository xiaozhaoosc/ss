"""
硬件调试脚本
测试 LED、屏幕显示和音频播放
"""

from device import DeviceManager
import time

def test_led_colors():
    """测试 LED 颜色显示"""
    print("\n=== 测试 LED 颜色 ===")
    device = DeviceManager()
    
    colors = {
        "红色": (255, 0, 0),
        "绿色": (0, 255, 0),
        "蓝色": (0, 0, 255),
        "黄色": (255, 255, 0),
        "白色": (255, 255, 255),
        "紫色": (200, 0, 255)
    }
    
    for name, color in colors.items():
        print(f"显示 {name}: RGB{color}")
        device.set_rgb_color(*color)
        time.sleep(2)
    
    # 测试状态颜色
    print("\n测试状态颜色:")
    for status in ["init", "idle", "running", "step_complete", "offline"]:
        print(f"状态: {status}")
        device.set_led_status(status)
        time.sleep(2)
    
    device.clear_rgb()
    print("LED 测试完成")

def test_display():
    """测试屏幕显示"""
    print("\n=== 测试屏幕显示 ===")
    device = DeviceManager()
    
    # 测试 1: 清屏
    print("测试 1: 清屏（黑色）")
    device.tft.fill(0x0000)
    time.sleep(1)
    
    # 测试 2: 填充颜色
    print("测试 2: 填充红色")
    device.tft.fill(0xF800)
    time.sleep(1)
    
    # 测试 3: 文本显示
    print("测试 3: 文本显示")
    device.tft.fill(0x0000)  # 黑色背景
    device.tft.text("Small Steps", 10, 10, 0xFFFF)  # 白色文字
    device.tft.text("Ready...", 10, 30, 0xFFE0)     # 黄色文字
    device.tft.text("Test 123", 10, 50, 0x07E0)     # 绿色文字
    time.sleep(2)
    
    # 测试 4: show_idle_screen
    print("测试 4: show_idle_screen()")
    device.show_idle_screen()
    time.sleep(2)
    
    print("屏幕测试完成")

def test_audio():
    """测试音频播放"""
    print("\n=== 测试音频播放 ===")
    device = DeviceManager()
    
    # 检查音频文件是否存在
    import os
    sound_dir = "/wavs"
    
    try:
        files = os.listdir(sound_dir)
        print(f"音频目录 {sound_dir} 中的文件:")
        for f in files:
            print(f"  - {f}")
    except:
        print(f"错误: 无法访问 {sound_dir} 目录")
        return
    
    # 测试播放每个音效
    for i in range(1, 8):
        filename = f"{sound_dir}/{i:03d}.wav"
        print(f"\n播放音效 {i}: {filename}")
        
        try:
            # 检查文件是否存在
            with open(filename, 'rb') as f:
                size = f.seek(0, 2)  # 移动到文件末尾获取大小
                print(f"  文件大小: {size} 字节")
            
            # 播放音效
            device.play_sound(i)
            time.sleep(1)  # 等待播放完成
            
        except OSError as e:
            print(f"  错误: 文件不存在或无法读取 - {e}")
    
    print("\n音频测试完成")

def main():
    """主测试函数"""
    print("=" * 50)
    print("Small Steps 硬件调试工具")
    print("=" * 50)
    
    while True:
        print("\n请选择测试项目:")
        print("1. 测试 LED 颜色")
        print("2. 测试屏幕显示")
        print("3. 测试音频播放")
        print("4. 运行所有测试")
        print("0. 退出")
        
        choice = input("\n输入选项 (0-4): ").strip()
        
        if choice == "1":
            test_led_colors()
        elif choice == "2":
            test_display()
        elif choice == "3":
            test_audio()
        elif choice == "4":
            test_led_colors()
            test_display()
            test_audio()
        elif choice == "0":
            print("退出测试")
            break
        else:
            print("无效选项，请重新输入")

if __name__ == "__main__":
    # 在 MicroPython 中直接运行测试
    print("开始快速诊断...")
    
    # 快速测试 LED
    print("\n1. 测试 LED (应该显示黄色)")
    from device import DeviceManager
    device = DeviceManager()
    device.set_led_status("idle")
    print(f"   LED_COLORS['idle'] = {device.LED_COLORS['idle']}")
    
    # 快速测试屏幕
    print("\n2. 测试屏幕")
    device.show_idle_screen()
    
    # 快速测试音频
    print("\n3. 测试音频 (播放音效 5)")
    device.play_sound(5)
    
    print("\n快速诊断完成！")
    print("如需详细测试，请在 REPL 中运行: import test_hardware_debug")
