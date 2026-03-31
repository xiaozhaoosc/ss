from device import DeviceManager
import time
import os
import gc

def full_recording_test():
    print("=== Complete Recording Test ===")
    
    # 1. 删除旧文件
    try:
        os.remove("test_record.wav")
        print("Deleted old recording file")
    except:
        print("No old file to delete")
    
    # 2. 初始化设备
    print("\nInitializing device...")
    gc.collect()
    dev = DeviceManager()
    print(f"Free memory: {gc.mem_free()} bytes")
    
    # 3. 录音
    print("\n=== Starting 5-second recording ===")
    print("Please speak NOW...")
    success = dev.record_audio("test_record.wav", duration_sec=5)
    
    if not success:
        print("Recording FAILED!")
        return
    
    # 4. 检查文件
    try:
        stat = os.stat("test_record.wav")
        print(f"\n✅ Recording saved: {stat[6]} bytes")
    except:
        print("\n❌ File not found!")
        return
    
    # 5. 快速分析前几个采样
    print("\n=== Quick Analysis ===")
    import struct
    with open("test_record.wav", 'rb') as f:
        f.seek(44)  # 跳过WAV头
        samples = []
        for i in range(32):
            data = f.read(2)
            if len(data) < 2:
                break
            sample = struct.unpack('<h', data)[0]
            samples.append(sample)
        
        print(f"First 32 samples: {samples[:16]}")
        
        non_zero = sum(1 for s in samples if s != 0)
        unique = len(set(samples))
        
        print(f"Non-zero: {non_zero}/32")
        print(f"Unique values: {unique}")
        
        if unique == 1:
            print("⚠️ WARNING: All samples are the same value!")
        elif unique > 10:
            print("✅ Good variation in data")
        else:
            print("⚠️ Low variation")

if __name__ == "__main__":
    full_recording_test()
