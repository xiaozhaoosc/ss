from lib.dfplayermini import DFPlayerMini
import config
import time

# ========================================
# DFPlayer 最大音量测试
# ========================================
# 针对 3.3V 供电的优化测试
# ========================================

def test_max_volume():
    print("=== DFPlayer Max Volume Test (3.3V) ===\n")
    
    # 初始化
    print("[1] Initializing DFPlayer...")
    player = DFPlayerMini(
        uart_id=config.DFPLAYER_UART_ID,
        tx_pin=config.DFPLAYER_TX_PIN,
        rx_pin=config.DFPLAYER_RX_PIN
    )
    print("OK\n")
    
    # 重置并等待稳定
    print("[2] Resetting and waiting for stabilization...")
    player.reset()
    time.sleep(3)
    print("OK\n")
    
    # 设置音量到最大
    print("[3] Setting volume to MAXIMUM (30)...")
    player.volume(30)
    time.sleep(1)
    print("OK\n")
    
    # 设置 EQ 为 Bass（增强低音，可能更容易听到）
    print("[4] Setting EQ to Bass...")
    player.eq(5)  # 5 = Bass
    time.sleep(1)
    print("OK\n")
    
    # 长时间播放测试
    print("[5] Playing folder 01, file 001 for 15 seconds...")
    print("*** PUT YOUR EAR CLOSE TO THE SPEAKER ***")
    print("*** LISTEN CAREFULLY FOR ANY SOUND ***")
    print("")
    
    player.play(folder=1, file=1)
    
    for i in range(15):
        print("  " + str(15-i) + " seconds remaining...")
        time.sleep(1)
    
    player.stop()
    print("\n[6] Test complete.\n")
    
    print("=== Results ===")
    print("Did you hear ANY sound? (Even very quiet)")
    print("")
    print("If YES:")
    print("  -> DFPlayer works! Volume is just too low with 3.3V")
    print("  -> Solution: Use 5V power supply")
    print("")
    print("If NO:")
    print("  -> Check the following:")
    print("     1. Is speaker connected correctly?")
    print("     2. Try a different speaker or headphones")
    print("     3. Check if DFPlayer LED blinks during playback")
    print("     4. Verify SD card files on computer")
    print("")
    print("Next step: Switch to 5V power supply")
    print("  DFPlayer VCC -> 5V power board (instead of 3.3V)")

if __name__ == "__main__":
    test_max_volume()
