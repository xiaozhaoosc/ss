from machine import Pin, I2S
import time

# INMP441 引脚
SCK_PIN = 41
WS_PIN = 42
SD_PIN = 2

def detailed_mic_debug():
    print("=== Detailed Mic Debug ===")
    
    try:
        audio_in = I2S(1,
                       sck=Pin(SCK_PIN),
                       ws=Pin(WS_PIN),
                       sd=Pin(SD_PIN),
                       mode=I2S.RX,
                       bits=32,
                       format=I2S.STEREO,
                       rate=16000,
                       ibuf=8192)
        
        buf = bytearray(256)
        print("Reading 256 bytes...")
        audio_in.readinto(buf)
        
        # 打印原始十六进制数据
        print("\nRaw hex data (first 64 bytes):")
        for i in range(0, 64, 16):
            hex_line = " ".join([f"{buf[j]:02x}" for j in range(i, min(i+16, 64))])
            print(f"  {i:03d}: {hex_line}")
        
        # 分析左右声道
        print("\nChannel Analysis (first 8 samples):")
        for i in range(0, 64, 8):
            left = f"{buf[i]:02x} {buf[i+1]:02x} {buf[i+2]:02x} {buf[i+3]:02x}"
            right = f"{buf[i+4]:02x} {buf[i+5]:02x} {buf[i+6]:02x} {buf[i+7]:02x}"
            print(f"  Sample {i//8}: L=[{left}] R=[{right}]")
        
        audio_in.deinit()
        
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    detailed_mic_debug()
