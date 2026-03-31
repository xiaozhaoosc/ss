import struct

# 模拟右声道的一个32位采样: 1f 00 00 00
raw_bytes = bytes([0x1f, 0x00, 0x00, 0x00])

print("=== Testing different extraction methods ===")
print(f"Raw bytes: {' '.join([f'{b:02x}' for b in raw_bytes])}")
print()

# 方法1: 字节0和1 (小端序)
val1 = struct.unpack('<h', raw_bytes[0:2])[0]
print(f"Method 1 (bytes 0-1, little-endian): {val1}")

# 方法2: 字节1和2 (小端序) - 当前代码使用的
val2 = struct.unpack('<h', raw_bytes[1:3])[0]
print(f"Method 2 (bytes 1-2, little-endian): {val2}")

# 方法3: 字节2和3 (小端序)
val3 = struct.unpack('<h', raw_bytes[2:4])[0]
print(f"Method 3 (bytes 2-3, little-endian): {val3}")

# 方法4: 字节0和1 (大端序)
val4 = struct.unpack('>h', raw_bytes[0:2])[0]
print(f"Method 4 (bytes 0-1, big-endian): {val4}")

print()
print("Expected: A non-zero value representing audio signal")
print(f"Most likely correct: Method 1 = {val1}")
