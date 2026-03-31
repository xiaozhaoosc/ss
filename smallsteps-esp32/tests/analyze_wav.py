import struct

def analyze_wav(filename="test_record.wav"):
    print(f"=== Analyzing {filename} ===")
    
    try:
        with open(filename, 'rb') as f:
            # 读取 WAV 头
            header = f.read(44)
            
            # 解析关键参数
            sample_rate = struct.unpack('<I', header[24:28])[0]
            bits = struct.unpack('<H', header[34:36])[0]
            
            print(f"Sample Rate: {sample_rate} Hz")
            print(f"Bit Depth: {bits} bits")
            
            # 读取前 256 个采样点
            samples = []
            for i in range(256):
                data = f.read(2)
                if len(data) < 2:
                    break
                sample = struct.unpack('<h', data)[0]
                samples.append(sample)
            
            # 统计分析
            non_zero = sum(1 for s in samples if s != 0)
            max_val = max(samples)
            min_val = min(samples)
            avg_abs = sum(abs(s) for s in samples) // len(samples)
            
            print(f"\nData Analysis (first 256 samples):")
            print(f"  Non-zero samples: {non_zero}/{len(samples)}")
            print(f"  Range: [{min_val}, {max_val}]")
            print(f"  Average absolute value: {avg_abs}")
            
            # 打印前 32 个采样值
            print(f"\nFirst 32 samples:")
            for i in range(0, min(32, len(samples)), 8):
                vals = " ".join([f"{s:6d}" for s in samples[i:i+8]])
                print(f"  {vals}")
            
            # 判断
            if non_zero == 0:
                print("\n❌ SILENT: All samples are zero")
            elif avg_abs < 100:
                print("\n⚠️ VERY QUIET: Signal is too weak (may need more gain)")
            else:
                print("\n✅ SIGNAL DETECTED: Audio data looks valid")
                
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    analyze_wav()
