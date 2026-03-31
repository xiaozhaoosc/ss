"""
音效播放测试脚本
测试所有 7 个音效文件的播放
"""

from device import DeviceManager
import config
import time

def test_all_sounds():
    """测试所有音效"""
    print("=" * 60)
    print("音效播放测试")
    print("=" * 60)
    
    # 初始化设备
    print("\n初始化硬件...")
    device = DeviceManager()
    
    # 音效列表
    sounds = [
        (config.SOUND_WELCOME, "欢迎音效"),
        (config.SOUND_NEW_TASK, "新任务提示音"),
        (config.SOUND_STEP_COMPLETE, "步骤完成音效"),
        (config.SOUND_TASK_COMPLETE, "任务完成音乐"),
        (config.SOUND_BUTTON_CLICK, "按键反馈音"),
        (config.SOUND_PAUSE, "暂停音效"),
        (config.SOUND_ERROR, "错误音效"),
    ]
    
    print(f"\n开始测试 {len(sounds)} 个音效...")
    print("=" * 60)
    
    for sound_id, name in sounds:
        print(f"\n🔊 播放: [{sound_id:03d}.wav] {name}")
        
        try:
            device.play_sound(sound_id)
            print("   ✅ 播放成功")
        except Exception as e:
            print(f"   ❌ 播放失败: {e}")
        
        # 等待播放完成
        time.sleep(2)
    
    print("\n" + "=" * 60)
    print("✅ 测试完成")
    print("=" * 60)

def test_single_sound(sound_id):
    """测试单个音效"""
    print(f"\n测试音效: {sound_id:03d}.wav")
    
    device = DeviceManager()
    device.play_sound(sound_id)
    
    print("播放完成")

if __name__ == "__main__":
    import sys
    
    if len(sys.argv) > 1:
        # 测试单个音效
        sound_id = int(sys.argv[1])
        test_single_sound(sound_id)
    else:
        # 测试所有音效
        test_all_sounds()
