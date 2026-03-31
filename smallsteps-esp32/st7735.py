import time
from machine import SPI, Pin
import struct

# 常用颜色定义 (RGB565)
BLACK   = 0x0000
BLUE    = 0x001F
RED     = 0xF800
GREEN   = 0x07E0
CYAN    = 0x07FF
MAGENTA = 0xF81F
YELLOW  = 0xFFE0
WHITE   = 0xFFFF

class ST7735:
    def __init__(self, spi, dc, cs, rst=None, blk=None, width=128, height=160):
        self.spi = spi
        self.dc = dc
        self.cs = cs
        self.rst = rst
        self.blk = blk
        self.width = width
        self.height = height
        
        # 偏移量 (不同屏幕批次可能需要微调，常见为 0,0 或 2,1)
        self.xstart = 0
        self.ystart = 0

        self.cs.init(Pin.OUT, value=1)
        self.dc.init(Pin.OUT, value=0)
        if self.rst:
            self.rst.init(Pin.OUT, value=1)
        if self.blk:
            self.blk.init(Pin.OUT, value=1)
            
        self.reset()
        self.init_display()

    def write_cmd(self, cmd):
        self.dc(0)
        self.cs(0)
        self.spi.write(bytearray([cmd]))
        self.cs(1)

    def write_data(self, buf):
        self.dc(1)
        self.cs(0)
        self.spi.write(bytearray([buf]) if isinstance(buf, int) else buf)
        self.cs(1)

    def reset(self):
        if self.rst:
            self.rst(0)
            time.sleep_ms(50)
            self.rst(1)
            time.sleep_ms(50)

    def init_display(self):
        # ST7735S 初始化序列
        self.write_cmd(0x01) # SWRESET
        time.sleep_ms(150)
        self.write_cmd(0x11) # SLPOUT
        time.sleep_ms(200)
        
        # 颜色模式 16-bit
        self.write_cmd(0x3A) 
        self.write_data(0x05)
        
        # 内存访问控制 (方向控制)
        # 0xC0 = BGR (常见), 0xC8 = MV|BGR (横屏)
        # 如果颜色不对，修改这里：0x00(RGB), 0x08(BGR)
        self.write_cmd(0x36) 
        self.write_data(0xC0) # 竖屏 BGR 模式

        self.write_cmd(0x29) # DISPON
        time.sleep_ms(100)

    def set_window(self, x0, y0, x1, y1):
        x0 += self.xstart
        x1 += self.xstart
        y0 += self.ystart
        y1 += self.ystart
        
        self.write_cmd(0x2A) # CASET
        self.write_data(struct.pack(">HH", x0, x1))
        self.write_cmd(0x2B) # RASET
        self.write_data(struct.pack(">HH", y0, y1))
        self.write_cmd(0x2C) # RAMWR

    def fill(self, color):
        self.set_window(0, 0, self.width-1, self.height-1)
        # 创建一行缓冲区加速填充
        chunk = struct.pack(">H", color) * self.width
        self.dc(1)
        self.cs(0)
        for _ in range(self.height):
            self.spi.write(chunk)
        self.cs(1)

    def pixel(self, x, y, color):
        if 0 <= x < self.width and 0 <= y < self.height:
            self.set_window(x, y, x, y)
            self.write_data(struct.pack(">H", color))

    # 简易 5x8 字符绘制
    def char(self, char, x, y, color, bg=BLACK):
        font = [
            0x00, 0x00, 0x00, 0x00, 0x00, # space
            0x00, 0x00, 0x5F, 0x00, 0x00, # !
            # ... 这里为了精简省略了完整字库
            # 实际使用建议加载完整的 font 库或使用 framebuf
        ]
        # 使用 MicroPython 内置 framebuf 绘制文字会更简单
        # 下面 main.py 会演示使用 framebuf
        pass