from device import DeviceManager
from audio_out import I2SAudioPlayer
import time

def run_test():
    print("=== MAX98357A Audio Verification (Survival Mode) ===")
    try:
        dev = DeviceManager()
        if not hasattr(dev, 'audio_out') or dev.audio_out is None:
            print("Failed to initialize I2S Audio. Check console logs.")
            return
            
        player = I2SAudioPlayer(dev.audio_out)
        print("1. Testing 440Hz Tone for 2 seconds...")
        player.test_tone(freq=440, duration_sec=2)
        
        time.sleep(1)
        
        print("2. Testing 880Hz Tone for 1 second...")
        player.test_tone(freq=880, duration_sec=1)
        
        print("\nVerification Script Completed.")
        print("Current Pins: DIN:16, BCLK:8, LRC:21")
    except Exception as e:
        print(f"Test Crashed: {e}")

if __name__ == "__main__":
    run_test()
