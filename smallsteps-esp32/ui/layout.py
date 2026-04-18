# -*- coding: utf-8 -*-
import gc

class SlidingWindowLayout:
    """
    AOT (Ahead-of-Time) Sliding Window Layout Engine
    Supports mixed-width (ASCII=8, CJK=16) and windowed pre-calculation.
    """
    def __init__(self, text, max_width=128, line_height=18):
        self.text = text
        self.max_width = max_width
        self.line_height = line_height
        
        # Windowed line cache: list of (char_start, char_length)
        self.line_window = []
        self.current_window_start_line = -1
        self.total_lines_approx = len(text) // (max_width // 12) # Rough estimate
        
    def _is_cjk(self, char):
        # Basic check for CJK/Wide characters
        return ord(char) > 255
        
    def _get_char_width(self, char):
        return 16 if self._is_cjk(char) else 8

    def update_window(self, start_line_idx, window_size=30):
        """
        Refill the sliding window with line metadata.
        This is the "Phase A" (AOT Prep) triggered on scroll.
        """
        if start_line_idx == self.current_window_start_line:
            return # Already cached

        self.line_window = []
        
        # To find start_line_idx, we need a "checkpoint" or relative seek.
        # For a simple prototype, we'll scan from start if not indexed, 
        # but in production, we'd store page-level checkpoints.
        
        current_char_idx = 0
        current_line_count = 0
        
        # 1. Skip lines until start_line_idx (Potential optimization needed for mega-texts)
        while current_line_count < start_line_idx and current_char_idx < len(self.text):
            line_w = 0
            while current_char_idx < len(self.text):
                cw = self._get_char_width(self.text[current_char_idx])
                if line_w + cw > self.max_width:
                    break
                # Handle manual newlines
                if self.text[current_char_idx] == '\n':
                    current_char_idx += 1
                    break
                line_w += cw
                current_char_idx += 1
            current_line_count += 1

        # 2. Fill the window
        while len(self.line_window) < window_size and current_char_idx < len(self.text):
            line_start = current_char_idx
            line_w = 0
            while current_char_idx < len(self.text):
                cw = self._get_char_width(self.text[current_char_idx])
                if line_w + cw > self.max_width:
                    break
                if self.text[current_char_idx] == '\n':
                    current_char_idx += 1
                    break
                line_w += cw
                current_char_idx += 1
            
            self.line_window.append((line_start, current_char_idx - line_start))
            
        self.current_window_start_line = start_line_idx
        gc.collect() # Aggressive GC after heavy string scanning

    def get_total_lines(self):
        """
        Scans all text to count total lines after wrapping.
        For task items, text is short so this is cheap.
        """
        # Save current window state
        saved_start = self.current_window_start_line
        saved_window = self.line_window[:]
        
        # Scan everything
        self.update_window(0, window_size=999)
        total = len(self.line_window)
        
        # Restore state
        self.current_window_start_line = saved_start
        self.line_window = saved_window
        return total

    def get_line_info(self, absolute_line_idx):
        """Returns (char_start, length) for a line index"""
        rel_idx = absolute_line_idx - self.current_window_start_line
        if 0 <= rel_idx < len(self.line_window):
            return self.line_window[rel_idx]
        return None

    def get_line_text(self, absolute_line_idx):
        info = self.get_line_info(absolute_line_idx)
        if info:
            start, length = info
            return self.text[start : start + length].strip('\n')
        return None
