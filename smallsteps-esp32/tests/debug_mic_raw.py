from machine import Pin, I2S
import time
import gc

# 使用硬件配置文件中的引脚
SCK_PIN = 41
WS_PIN = 42
SD_PIN = 2

def debug_mic():
    print("=== Mic Raw Data Debug ===")
    gc.collect()
    
    # 尝试多种组合 (INMP441 常见规格: 24/32bit, MONO/STEREO)
    configs = [
        {"bits": 16, "format": I2S.MONO, "label": "16-bit Mono (Current)"},
        {"bits": 32, "format": I2S.MONO, "label": "32-bit Mono"},
        {"bits": 32, "format": I2S.STEREO, "label": "32-bit Stereo"},
    ]
    
    for cfg in configs:
        print(f"\n--- Testing: {cfg['label']} ---")
        try:
            audio_in = I2S(1,
                           sck=Pin(SCK_PIN),
                           ws=Pin(WS_PIN),
                           sd=Pin(SD_PIN),
                           mode=I2S.RX,
                           bits=cfg["bits"],
                           format=cfg["format"],
                           rate=16000,
                           ibuf=4096)
            
            # 读取一小段数据进行分析
            buf = bytearray(256)
            num_read = audio_in.readinto(buf)
            
            if num_read > 0:
                # 打印前 64 字节
                hex_data = " ".join([f"{b:02x}" for b in buf[:64]])
                print(f"Read {num_read} bytes: {hex_data}")
                
                # 统计非零字节
                non_zero = sum(1 for b in buf if b != 0)
                all_ff = sum(1 for b in buf if b == 0xff)
                
                print(f"Analysis: Non-zero count: {non_zero}/{len(buf)}, All-FF count: {all_ff}/{len(buf)}")
                
                if non_zero == 0:
                    print("Status: 🔇 SILENT (All zeros) - Likely wiring or L/R pin issue.")
                elif all_ff == len(buf):
                    print("Status: ⚠️ NOISY (All 0xFF) - Check SCK/WS clock or 5V/3.3V power.")
                else:
                    print("Status: ✅ DATA DETECTED! (Dynamic values found)")
            else:
                print("Status: ❌ READ FAILED")
            
            audio_in.deinit()
        except Exception as e:
            print(f"Error: {e}")
        
        time.sleep(0.5)

if __name__ == "__main__":
    debug_mic()
    print("\nDebug complete. If all tests show 'SILENT', check L/R pin (must be GND) and VCC.")
