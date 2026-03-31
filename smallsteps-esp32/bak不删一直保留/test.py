from device import DeviceManager
import time

print("=== Hardware Diagnostic Tool ===")
sys = DeviceManager()

# 1. Test RGB
print("\n[TEST 1/3] RGB Ring (Pin 21)")
print("  - Expect: Red -> Green -> Blue")
try:
    sys.set_rgb_color(50, 0, 0)
    time.sleep(0.5)
    sys.set_rgb_color(0, 50, 0)
    time.sleep(0.5)
    sys.set_rgb_color(0, 0, 50)
    time.sleep(0.5)
    sys.clear_rgb()
    print("  - Done")
except Exception as e:
    print(f"  - FAIL: {e}")

# 2. Test Motor
print("\n[TEST 2/3] Vibration Motor (Pin 14)")
print("  - Expect: Short Buzz -> Short Buzz")
try:
    sys.vibrate(200)
    time.sleep(0.5)
    sys.vibrate(200)
    print("  - Done")
except Exception as e:
    print(f"  - FAIL: {e}")

# 3. Test Audio
print("\n[TEST 3/3] Audio (TX=18, RX=17)")
print("  - Expect: '0001.mp3' playback")
try:
    if sys.player:
        sys.player.volume(30)
        sys.player.play(1)
        print("  - Playing command sent...")
    else:
        print("  - SKIP: Player not initialized")
except Exception as e:
    print(f"  - FAIL: {e}")

print("\n=== End of Test ===")
