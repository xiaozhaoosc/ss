from device import DeviceManager
import time

def run_mic_test():
    print("=== INMP441 Microphone Recording Test ===")
    try:
        dev = DeviceManager()
        
        # 定义录音参数
        filename = "test_record.wav"
        duration = 5 # 录音 5 秒
        
        import gc
        print(f"Current free memory: {gc.mem_free()} bytes")
        
        print(f"Starting {duration}s recording...")
        print("Please speak into the microphone...")
        
        success = dev.record_audio(filename=filename, duration_sec=duration)
        
        if success:
            print(f"\nRecording successful! File saved as: {filename}")
            print("To verify, you can:")
            print("1. Download the file and play it on your computer.")
            print("2. (If speaker is connected) Use a script to play back this WAV.")
        else:
            print("\nRecording failed. Please check your wiring (SCK:41, WS:42, SD:2).")

    except Exception as e:
        print(f"Mic Test Crashed: {e}")

if __name__ == "__main__":
    run_mic_test()
