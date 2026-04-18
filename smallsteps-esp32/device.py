from machine import Pin, SPI, I2S, UART
import os
import utime
import neopixel
import st7735
from dfplayermini import DFPlayerMini
import network
import bluetooth
import time
import struct
import config

class HardwareConfig:
    # Pin Definitions (ESP32-S3)
    
    # Display (ST7735)
    PIN_LCD_SCLK = 12
    PIN_LCD_MOSI = 11
    PIN_LCD_MISO = 13 # Not connected, but needed for SoftSPI/HardSPI config
    PIN_LCD_CS   = 10
    PIN_LCD_DC   = 9
    PIN_LCD_RST  = 46
    PIN_LCD_BLK  = 3
    
    # Buttons
    PIN_BTN_UP   = 4
    PIN_BTN_DOWN = 5
    PIN_BTN_OK   = 6
    PIN_BTN_BACK = 7
    
    # Audio (DFPlayer) - UART1
    PIN_DF_TX    = 18 # Connect to DF RX
    PIN_DF_RX    = 17 # Connect to DF TX
    
    # Microphone (I2S)
    PIN_MIC_SCK  = 41
    PIN_MIC_WS   = 42
    PIN_MIC_SD   = 2
    
    # Light (WS2812B)
    PIN_RGB      = 21 # Changed to 21 (48 is often internal only)
    RGB_COUNT    = 12 # 12-LED Ring
    
    # Haptic
    PIN_MOTOR    = 14 # Changed to 14 (1 is UART0 TX, avoid!)
    
    # NFC (RC522) - Commented out until hardware is connected
    # PIN_NFC_SCLK = 6
    # PIN_NFC_MOSI = 7
    # PIN_NFC_MISO = 2
    # PIN_NFC_RST  = 4
    # PIN_NFC_CS   = 5

class DeviceManager:
    def __init__(self):
        print("Initializing Hardware...")
        self.init_display()
        self.init_buttons()
        self.init_rgb()
        self.init_audio()
        self.init_haptic()
        self.init_wifi()
        self.init_ble()
        
    def init_display(self):
        # SPI2 for S3
        self.spi = SPI(2, baudrate=20000000, polarity=0, phase=0,
                       sck=Pin(HardwareConfig.PIN_LCD_SCLK),
                       mosi=Pin(HardwareConfig.PIN_LCD_MOSI),
                       miso=Pin(HardwareConfig.PIN_LCD_MISO))
                       
        self.tft = st7735.ST7735(self.spi,
                                 dc=Pin(HardwareConfig.PIN_LCD_DC),
                                 cs=Pin(HardwareConfig.PIN_LCD_CS),
                                 rst=Pin(HardwareConfig.PIN_LCD_RST),
                                 blk=Pin(HardwareConfig.PIN_LCD_BLK))
        print("Display Initialized")

    def init_buttons(self):
        self.btn_up   = Pin(HardwareConfig.PIN_BTN_UP, Pin.IN, Pin.PULL_UP)
        self.btn_down = Pin(HardwareConfig.PIN_BTN_DOWN, Pin.IN, Pin.PULL_UP)
        self.btn_ok   = Pin(HardwareConfig.PIN_BTN_OK, Pin.IN, Pin.PULL_UP)
        self.btn_back = Pin(HardwareConfig.PIN_BTN_BACK, Pin.IN, Pin.PULL_UP)
        print("Buttons Initialized")

    def init_rgb(self):
        self.np = neopixel.NeoPixel(Pin(HardwareConfig.PIN_RGB), HardwareConfig.RGB_COUNT)
        self.clear_rgb()
        print("RGB Ring Initialized")

    def clear_rgb(self):
        for i in range(HardwareConfig.RGB_COUNT):
            self.np[i] = (0, 0, 0)
        self.np.write()

    def set_rgb_color(self, r, g, b):
        for i in range(HardwareConfig.RGB_COUNT):
            self.np[i] = (r, g, b)
        self.np.write()

    def init_audio(self):
        try:
            # UART1 for DFPlayer
            self.player = DFPlayerMini(1, tx_pin=HardwareConfig.PIN_DF_TX, rx_pin=HardwareConfig.PIN_DF_RX)
            self.player.reset()
            time.sleep(1) # Wait for reset
            self.player.volume(30) # Max volume
            print("Audio Initialized")
        except Exception as e:
            print(f"Audio Init Failed: {e}")
            self.player = None

    def init_haptic(self):
        self.motor = Pin(HardwareConfig.PIN_MOTOR, Pin.OUT)
        self.motor.value(0)
        print("Haptic Initialized")

    def vibrate(self, duration_ms=100):
        self.motor.value(1)
        time.sleep_ms(duration_ms)
        self.motor.value(0)

    def init_wifi(self):
        from manager import WiFiManager
        self.wifi = WiFiManager()
        print("WiFi Initialized (Manager)")

    def connect_wifi(self):
        success = self.wifi.connect()
        if success:
            # Auto sync time on connection
            self.wifi.sync_time()
            return self.wifi.get_status()
        return False

    def init_ble(self):
        self.ble = bluetooth.BLE()
        self.ble.active(True)
        print("BLE Initialized")

    def advertise_ble(self):
        name = config.BLE_NAME
        # Flags (General Discoverable Mode) + Name
        payload = struct.pack("BB", 0x02, 0x01) + struct.pack("B", 0x06) + \
                  struct.pack("BB", len(name) + 1, 0x09) + name.encode()
        
        # Advertise for 100ms interval
        self.ble.gap_advertise(100000, adv_data=payload)
        print(f"Advertising BLE: {name}")
        
    def stop_ble(self):
        self.ble.gap_advertise(None)
        print("BLE Stopped")

    # def init_nfc(self):
    #     import mfrc522
    #     try:
    #         self.nfc = mfrc522.MFRC522(sck=HardwareConfig.PIN_NFC_SCLK,
    #                                    mosi=HardwareConfig.PIN_NFC_MOSI,
    #                                    miso=HardwareConfig.PIN_NFC_MISO,
    #                                    rst=HardwareConfig.PIN_NFC_RST,
    #                                    cs=HardwareConfig.PIN_NFC_CS)
    #         print("NFC Initialized")
    #     except Exception as e:
    #         print(f"NFC Init Failed: {e}")
    #         self.nfc = None

    def set_led_ring(self, color, brightness=1.0):
        r, g, b = color
        for i in range(HardwareConfig.RGB_COUNT):
            self.np[i] = (int(r * brightness), int(g * brightness), int(b * brightness))
        self.np.write()

    def record_audio(self, filename="rec.wav", duration_sec=5, update_cb=None):
        # Basic I2S Recording Implementation
        try:
            audio_in = I2S(0,
                           sck=Pin(HardwareConfig.PIN_MIC_SCK),
                           ws=Pin(HardwareConfig.PIN_MIC_WS),
                           sd=Pin(HardwareConfig.PIN_MIC_SD),
                           mode=I2S.RX,
                           bits=16,
                           format=I2S.MONO,
                           rate=16000,
                           ibuf=32768)
            
            # WAV Header
            SAMPLE_RATE = 16000
            BITS_PER_SAMPLE = 16
            NUM_CHANNELS = 1
            BYTE_RATE = SAMPLE_RATE * NUM_CHANNELS * BITS_PER_SAMPLE // 8
            BLOCK_ALIGN = NUM_CHANNELS * BITS_PER_SAMPLE // 8
            DATA_SIZE = SAMPLE_RATE * duration_sec * BLOCK_ALIGN
            
            with open(filename, 'wb') as f:
                f.write(b'RIFF')
                f.write(struct.pack('<I', 36 + DATA_SIZE))
                f.write(b'WAVEfmt ')
                f.write(struct.pack('<I', 16))
                f.write(struct.pack('<H', 1))
                f.write(struct.pack('<H', NUM_CHANNELS))
                f.write(struct.pack('<I', SAMPLE_RATE))
                f.write(struct.pack('<I', BYTE_RATE))
                f.write(struct.pack('<H', BLOCK_ALIGN))
                f.write(struct.pack('<H', BITS_PER_SAMPLE))
                f.write(b'data')
                f.write(struct.pack('<I', DATA_SIZE))
                
                buf = bytearray(4096)
                print(f"Recording to {filename}...")
                
                start_time = time.ticks_ms()
                while time.ticks_diff(time.ticks_ms(), start_time) < duration_sec * 1000:
                    num_read = audio_in.readinto(buf)
                    if num_read > 0:
                        f.write(buf[:num_read])
                    if update_cb:
                        update_cb(time.ticks_diff(time.ticks_ms(), start_time))
                        
            audio_in.deinit()
            print("Recording Saved")
            return True
        except Exception as e:
            print(f"Recording Failed: {e}")
            if 'audio_in' in locals():
                audio_in.deinit()
            return False

    def cleanup_secrets(self, directory="wavs"):
        # Ensure retention hours configuration
        retention_hours = config.VOICE_RETENTION_HOURS
        now = utime.time()
        
        # Security Check: If RTC is not synchronized (reset to 1970/2000), 
        # utime.time() will be a small number. We skip cleanup to avoid deleting fresh files.
        # Assuming 2024-01-01 is roughly 1704067200
        if now < 1704067200:
            print("RTC not synchronized. Skipping cleanup.")
            return

        try:
            # Check if directory exists
            try:
                files = os.listdir(directory)
            except OSError:
                print(f"Directory {directory} not found. Nothing to cleanup.")
                return

            print(f"Checking for expired secrets in {directory}...")
            count = 0
            for f in files:
                filepath = directory + "/" + f
                try:
                    stats = os.stat(filepath)
                    mtime = stats[8] # 8 is st_mtime in MicroPython
                    age_hours = (now - mtime) / 3600
                    
                    if age_hours > retention_hours:
                        print(f"Deleting expired secret: {f} (Age: {age_hours:.1f}h)")
                        os.remove(filepath)
                        count += 1
                except Exception as e:
                    print(f"Failed to process {f}: {e}")
            
            if count > 0:
                print(f"Cleanup complete. Removed {count} files.")
            else:
                print("No expired files found.")
                
        except Exception as e:
            print(f"Cleanup Failed: {e}")

