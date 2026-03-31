from device import DeviceManager
from audio_out import I2SAudioPlayer
import time
import os

def run_playback_test():
    print("=== Record & Playback Verification ===")
    filename = "test_record.wav"
    
    # 1. 检查录音文件是否存在
    try:
        stat = os.stat(filename)
        print(f"Found recording: {filename} ({stat[6]} bytes)")
    except OSError:
        print(f"Error: {filename} not found. Please run test_mic.py first.")
        return

    try:
        dev = DeviceManager()
        player = I2SAudioPlayer(dev.audio_out)
        
        print(f"Playing back {filename} through Speaker...")
        
        # 简单 WAV 播放逻辑 (跳过 44 字节头)
        with open(filename, 'rb') as f:
            f.seek(44) # 跳过 WAV 头
            
            # 使用 DeviceManager 已初始化的 audio_out (I2S 1)
            # 注意: 录制时是 16kHz Mono，播放器默认是 44.1kHz
            # 为了准确回放，我们需要临时调整波特率
            print("Adjusting I2S rate to 16000Hz for playback...")
            dev.init_i2s_audio(rate=16000) 
            
            buf = bytearray(4096)
            while True:
                num_read = f.readinto(buf)
                if num_read == 0:
                    break
                # 写入 I2S
                dev.audio_out.write(buf[:num_read])
                
        print("Playback Finished.")
        
        # 恢复默认采样率
        dev.init_i2s_audio(rate=44100)
        
    except Exception as e:
        print(f"Playback Failed: {e}")

if __name__ == "__main__":
    run_playback_test()
