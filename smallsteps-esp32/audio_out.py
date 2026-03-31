from machine import I2S, Pin
import struct
import time

class I2SAudioPlayer:
    def __init__(self, i2s_obj):
        self.i2s = i2s_obj

    def play_wav(self, filename):
        if not self.i2s:
            print("I2S not initialized")
            return

        try:
            with open(filename, "rb") as f:
                # 简单跳过 WAV 头部 (44 字节)
                f.seek(44)
                
                # 创建缓冲区
                buf = bytearray(4096)
                print(f"Playing {filename}...")
                
                while True:
                    n = f.readinto(buf)
                    if n == 0:
                        break
                    self.i2s.write(buf[:n])
                
                print("Playback finished")
        except Exception as e:
            print(f"Playback error: {e}")

    def test_tone(self, freq=440, duration_sec=1):
        """生成简单的方波测试音"""
        if not self.i2s: return
        
        sample_rate = 44100
        half_period = sample_rate // freq // 2
        
        # 构造半周期的静音和半周期的最大值数据
        high = struct.pack("<h", 32767) * half_period
        low = struct.pack("<h", -32768) * half_period
        chunk = high + low
        
        start = time.ticks_ms()
        while time.ticks_diff(time.ticks_ms(), start) < duration_sec * 1000:
            self.i2s.write(chunk)
