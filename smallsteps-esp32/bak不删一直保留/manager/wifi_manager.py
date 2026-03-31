import network
import time
import ntptime
import machine
import config

class WiFiManager:
    def __init__(self):
        self.wlan = network.WLAN(network.STA_IF)
        self.wlan.active(True)
        self.connected = False
        
    def connect(self, timeout_sec=10):
        if not self.wlan.isconnected():
            print(f"WiFi: Connecting to {config.WIFI_SSID}...")
            self.wlan.connect(config.WIFI_SSID, config.WIFI_PASS)
            
            start = time.ticks_ms()
            while not self.wlan.isconnected():
                if time.ticks_diff(time.ticks_ms(), start) > timeout_sec * 1000:
                    print("WiFi: Timeout")
                    return False
                time.sleep(0.1)
                
        print("WiFi: Connected", self.wlan.ifconfig())
        self.connected = True
        return True
        
    def is_connected(self):
        return self.wlan.isconnected()
        
    def sync_time(self):
        """Sync system time with NTP"""
        if not self.is_connected():
            print("NTP: No WiFi")
            return False
            
        try:
            print("NTP: Syncing...")
            ntptime.settime() # Sets internal RTC
            # UTC is set. China is UTC+8.
            # MicroPython might need manual offset handling if no timezone lib
            # But standard ntptime sets to UTC.
            print(f"NTP: Success. UTC Time: {time.localtime()}")
            return True
        except Exception as e:
            print(f"NTP: Failed {e}")
            return False
            
    def get_status(self):
        if not self.is_connected():
            return "Disconnected"
        ip = self.wlan.ifconfig()[0]
        rssi = self.wlan.status('rssi')
        return f"{ip} ({rssi}dBm)"
