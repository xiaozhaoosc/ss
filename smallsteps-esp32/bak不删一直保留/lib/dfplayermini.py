from machine import UART, Pin
import time

class DFPlayerMini:
    """
    MicroPython driver for DFPlayer Mini
    Compatible with: https://github.com/kevinmcaleer/dfplayermini
    """
    
    def __init__(self, uart_id, tx_pin, rx_pin):
        # Pass pin numbers directly as integers for S3 UART compatibility
        self.uart = UART(uart_id, baudrate=9600, tx=tx_pin, rx=rx_pin)
        self.wait_time = 0.1

    def send_cmd(self, command, parameter=0):
        # Command structure: Start, Ver, Len, Cmd, Feedback, Param_High, Param_Low, Checksum_High, Checksum_Low, End
        # Checksum = 0 - (Ver + Len + Cmd + Feedback + Param_High + Param_Low)
        
        version = 0xFF
        length = 0x06
        feedback = 0x00 # No feedback
        
        param_high = (parameter >> 8) & 0xFF
        param_low = parameter & 0xFF
        
        checksum = 0 - (version + length + command + feedback + param_high + param_low)
        checksum_high = (checksum >> 8) & 0xFF
        checksum_low = checksum & 0xFF
        
        cmd_bytes = bytearray([0x7E, version, length, command, feedback, param_high, param_low, checksum_high, checksum_low, 0xEF])
        
        self.uart.write(cmd_bytes)
        time.sleep(self.wait_time)

    def play(self, folder=None, file=None):
        if folder is None and file is None:
            # Play current 
            self.send_cmd(0x0D)
        elif folder is not None and file is not None:
             # Play specific folder/file (0x0F)
             # Folder 1-99, File 1-255
            self.send_cmd(0x0F, (folder << 8) | file)
        elif file is not None:
            # Play by index (0x03)
            self.send_cmd(0x03, file)

    def next(self):
        self.send_cmd(0x01)

    def prev(self):
        self.send_cmd(0x02)

    def volume(self, vol):
        # 0-30
        self.send_cmd(0x06, vol)
    
    def eq(self, eq):
        # 0=Normal, 1=Pop, 2=Rock, 3=Jazz, 4=Classic, 5=Bass
        self.send_cmd(0x07, eq)

    def reset(self):
        self.send_cmd(0x0C)
        time.sleep(2)
        
    def stop(self):
        self.send_cmd(0x16)
