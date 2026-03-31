"""
umqtt.simple - 简化的 MQTT 客户端库
用于 MicroPython ESP32
"""

import usocket as socket
import ustruct as struct
from ubinascii import hexlify

class MQTTException(Exception):
    pass

class MQTTClient:
    def __init__(self, client_id, server, port=1883, user=None, password=None, keepalive=60):
        """
        初始化 MQTT 客户端
        
        Args:
            client_id: 客户端 ID
            server: MQTT 服务器地址
            port: 端口号
            user: 用户名
            password: 密码
            keepalive: 心跳间隔（秒）
        """
        self.client_id = client_id
        self.server = server
        self.port = port
        self.user = user
        self.password = password
        self.keepalive = keepalive
        self.sock = None
        self.pid = 0
        self.cb = None
        self.connected = False

    def _send_str(self, s):
        """发送字符串（带长度前缀）"""
        self.sock.write(struct.pack("!H", len(s)))
        self.sock.write(s)

    def _recv_len(self):
        """接收长度字段"""
        n = 0
        sh = 0
        while 1:
            b = self.sock.read(1)[0]
            n |= (b & 0x7f) << sh
            if not b & 0x80:
                return n
            sh += 7

    def connect(self, clean_session=True):
        """连接到 MQTT 服务器"""
        print(f"[MQTT] Connecting to {self.server}:{self.port}")
        print(f"[MQTT] Client ID: {self.client_id}")
        print(f"[MQTT] User: {self.user if self.user else 'None'}")
        print(f"[MQTT] Keepalive: {self.keepalive}s")
        
        self.sock = socket.socket()
        addr = socket.getaddrinfo(self.server, self.port)[0][-1]
        print(f"[MQTT] Resolved address: {addr}")
        self.sock.connect(addr)
        print("[MQTT] Socket connected")
        
        # 构建 CONNECT 包
        premsg = bytearray(b"\x10\x00\x00\x04MQTT\x04\x02\x00\x00")
        msg = bytearray(b"\x00\x00")
        
        # 设置标志
        if clean_session:
            premsg[9] |= 0x02
        
        # 设置 keepalive
        premsg[10] = self.keepalive >> 8
        premsg[11] = self.keepalive & 0xFF
        
        # 添加客户端 ID
        msg.extend(struct.pack("!H", len(self.client_id)))
        msg.extend(self.client_id.encode())
        
        # 添加用户名和密码
        if self.user:
            premsg[9] |= 0x80
            msg.extend(struct.pack("!H", len(self.user)))
            msg.extend(self.user.encode())
            
            if self.password:
                premsg[9] |= 0x40
                msg.extend(struct.pack("!H", len(self.password)))
                msg.extend(self.password.encode())
        
        # 设置剩余长度
        remaining_length = len(msg) + 10
        i = 1
        while remaining_length > 0x7f:
            premsg[i] = (remaining_length & 0x7f) | 0x80
            remaining_length >>= 7
            i += 1
        premsg[i] = remaining_length
        
        # 发送 CONNECT 包
        self.sock.write(premsg[:i+1])
        self.sock.write(premsg[i+1:])
        self.sock.write(msg)
        print(f"[MQTT] CONNECT packet sent ({len(premsg[:i+1]) + len(premsg[i+1:]) + len(msg)} bytes)")
        
        # 接收 CONNACK
        print("[MQTT] Waiting for CONNACK...")
        resp = self.sock.read(4)
        print(f"[MQTT] Raw CONNACK received: {resp}")
        
        # 验证响应长度
        if not resp or len(resp) < 4:
            raise MQTTException(f"CONNACK 响应长度错误: {len(resp) if resp else 0} bytes, 期望 4 bytes")
        
        # 验证消息类型和长度
        if resp[0] != 0x20:
            raise MQTTException(f"CONNACK 消息类型错误: 0x{resp[0]:02x}, 期望 0x20")
        
        if resp[1] != 0x02:
            raise MQTTException(f"CONNACK 剩余长度错误: {resp[1]}, 期望 2")
        
        # 检查返回码
        if resp[3] != 0:
            error_codes = {
                1: "协议版本不支持",
                2: "客户端 ID 被拒绝",
                3: "服务器不可用",
                4: "用户名或密码错误",
                5: "未授权"
            }
            error_msg = error_codes.get(resp[3], f"未知错误码: {resp[3]}")
            raise MQTTException(f"连接被拒绝 - {error_msg}")
        
        self.connected = True
        print(f"[MQTT] CONNACK received: session_present={resp[2] & 1}")
        print("[MQTT] Connection successful!")
        return resp[2] & 1

    def disconnect(self):
        """断开连接"""
        if self.sock:
            self.sock.write(b"\xe0\x00")
            self.sock.close()
            self.connected = False

    def ping(self):
        """发送 PING"""
        self.sock.write(b"\xc0\x00")

    def publish(self, topic, msg, retain=False, qos=0):
        """
        发布消息
        
        Args:
            topic: 主题
            msg: 消息内容
            retain: 是否保留
            qos: QoS 级别（0, 1, 2）
        """
        pkt = bytearray(b"\x30\x00")
        pkt[0] |= qos << 1 | retain
        
        # 计算剩余长度
        sz = 2 + len(topic) + len(msg)
        if qos > 0:
            sz += 2
        
        # 编码剩余长度
        i = 1
        while sz > 0x7f:
            pkt[i] = (sz & 0x7f) | 0x80
            sz >>= 7
            i += 1
        pkt[i] = sz
        
        # 发送固定头
        self.sock.write(pkt[:i+1])
        
        # 发送主题
        self._send_str(topic.encode())
        
        # 发送消息 ID（如果 QoS > 0）
        if qos > 0:
            self.pid += 1
            self.sock.write(struct.pack("!H", self.pid))
        
        # 发送消息内容
        self.sock.write(msg.encode() if isinstance(msg, str) else msg)
        
        # 等待 PUBACK（如果 QoS > 0）
        if qos == 1:
            while 1:
                op = self.wait_msg()
                if op == 0x40:
                    sz = self.sock.read(1)
                    if sz == b"\x02":
                        rcv_pid = self.sock.read(2)
                        return
        elif qos == 2:
            raise NotImplementedError("QoS 2 not supported")

    def subscribe(self, topic, qos=0):
        """
        订阅主题
        
        Args:
            topic: 主题
            qos: QoS 级别
        """
        pkt = bytearray(b"\x82\x00")
        self.pid += 1
        
        # 计算剩余长度
        sz = 2 + 2 + len(topic) + 1
        
        # 编码剩余长度
        i = 1
        while sz > 0x7f:
            pkt[i] = (sz & 0x7f) | 0x80
            sz >>= 7
            i += 1
        pkt[i] = sz
        
        # 发送固定头
        self.sock.write(pkt[:i+1])
        
        # 发送消息 ID
        self.sock.write(struct.pack("!H", self.pid))
        
        # 发送主题
        self._send_str(topic.encode())
        
        # 发送 QoS
        self.sock.write(qos.to_bytes(1, "little"))
        
        # 等待 SUBACK
        while 1:
            op = self.wait_msg()
            if op == 0x90:
                resp = self.sock.read(4)
                return

    def set_callback(self, f):
        """设置消息回调函数"""
        self.cb = f

    def wait_msg(self):
        """等待消息"""
        res = self.sock.read(1)
        if res is None:
            return None
        if res == b"":
            raise OSError(-1)
        
        op = res[0]
        
        if op & 0xf0 != 0x30:
            return op
        
        # 接收 PUBLISH 消息
        sz = self._recv_len()
        topic_len = self.sock.read(2)
        topic_len = (topic_len[0] << 8) | topic_len[1]
        topic = self.sock.read(topic_len)
        sz -= topic_len + 2
        
        if op & 6:
            pid = self.sock.read(2)
            sz -= 2
        
        msg = self.sock.read(sz)
        
        if self.cb:
            self.cb(topic, msg)
        
        return op

    def check_msg(self):
        """检查是否有新消息（非阻塞）"""
        self.sock.setblocking(False)
        try:
            return self.wait_msg()
        finally:
            self.sock.setblocking(True)
