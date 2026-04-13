# -*- coding: utf-8 -*-
import st7735
from .font_mini import FONTS

def draw_char_16(fb, char_data, x, y, color):
    """
    Draw a 16x16 bitmap character (2 bytes per row, 16 rows)
    """
    for row in range(16):
        # 16 bits = 2 bytes
        byte1 = char_data[row * 2]
        byte2 = char_data[row * 2 + 1]
        
        # Draw byte 1 (left 8 bits)
        for bit in range(8):
            if byte1 & (0x80 >> bit):
                fb.pixel(x + bit, y + row, color)
        
        # Draw byte 2 (right 8 bits)
        for bit in range(8):
            if byte2 & (0x80 >> bit):
                fb.pixel(x + 8 + bit, y + row, color)

def draw_mixed_text(fb, text, x, y, color):
    """
    Iterate through text and draw ASCII (8px) or Chinese (16px)
    """
    curr_x = x
    for char in text:
        char_code = ord(char)
        if char_code > 255:
            # Chinese / Wide
            from .font_mini import get_font_data
            data = get_font_data(char)
            if data:
                draw_char_16(fb, data, curr_x, y, color)
                curr_x += 16
            else:
                # Fallback for missing glyph
                fb.rect(curr_x, y, 16, 16, color)
                curr_x += 16
        else:
            # ASCII (8px) - built-in font is 8x8, we align to 16h by centering
            fb.text(char, curr_x, y + 4, color)
            curr_x += 8
    return curr_x
