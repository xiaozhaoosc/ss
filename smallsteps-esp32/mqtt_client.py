"""
MQTT 通信模块
功能：封装 MQTT 连接、订阅、发布、自动重连逻辑
"""

from umqtt.simple import MQTTClient as UMQTTClient
import time
import json
import gc

class MQTTClient:
    """MQTT 客户端封装类"""
    
    def __init__(self, device_id, broker, port=1883, user=None, password=None, keepalive=60):
        """
        初始化 MQTT 客户端
        
        Args:
            device_id: 设备唯一 ID
            broker: MQTT Broker 地址
            port: MQTT 端口
            user: 用户名（可选）
            password: 密码（可选）
            keepalive: 心跳间隔（秒）
        """
        self.device_id = device_id
        self.broker = broker
        self.port = port
        self.user = user
        self.password = password
        self.keepalive = keepalive
        
        self.client = None
        self.connected = False
        self.callbacks = {}  # topic -> callback
        self.last_ping = 0
        
        print(f"[MQTT] Initialized for device: {device_id}")
    
    def connect(self):
        """
        连接到 MQTT Broker
        
        Returns:
            bool: 连接是否成功
        """
        try:
            # 创建客户端实例
            self.client = UMQTTClient(
                client_id=self.device_id,
                server=self.broker,
                port=self.port,
                user=self.user,
                password=self.password,
                keepalive=self.keepalive
            )
            
            # 设置消息回调
            self.client.set_callback(self._on_message)
            
            # 连接
            self.client.connect()
            self.connected = True
            self.last_ping = time.time()
            
            print(f"[MQTT] Connected to {self.broker}:{self.port}")
            gc.collect()
            return True
            
        except Exception as e:
            print(f"[MQTT] Connection failed: {e}")
            self.connected = False
            return False
    
    def disconnect(self):
        """断开 MQTT 连接"""
        if self.client and self.connected:
            try:
                self.client.disconnect()
                print("[MQTT] Disconnected")
            except:
                pass
            finally:
                self.connected = False
                self.client = None
    
    def subscribe(self, topic, callback):
        """
        订阅主题
        
        Args:
            topic: 主题名称
            callback: 回调函数 callback(topic, payload_dict)
        
        Returns:
            bool: 订阅是否成功
        """
        if not self.connected:
            print(f"[MQTT] Cannot subscribe: not connected")
            return False
        
        try:
            self.client.subscribe(topic)
            self.callbacks[topic] = callback
            print(f"[MQTT] Subscribed to: {topic}")
            return True
        except Exception as e:
            print(f"[MQTT] Subscribe failed: {e}")
            return False
    
    def publish(self, topic, payload, qos=1, retain=False):
        """
        发布消息
        
        Args:
            topic: 主题名称
            payload: 消息内容（dict 或 str）
            qos: QoS 等级（0, 1, 2）
            retain: 是否保留消息
        
        Returns:
            bool: 发布是否成功
        """
        if not self.connected:
            print(f"[MQTT] Cannot publish: not connected")
            return False
        
        try:
            # 如果是字典，转换为 JSON
            if isinstance(payload, dict):
                payload = json.dumps(payload)
            
            # 发布消息
            self.client.publish(topic, payload, qos=qos, retain=retain)
            print(f"[MQTT] Published to {topic}: {payload[:50]}...")
            return True
            
        except Exception as e:
            print(f"[MQTT] Publish failed: {e}")
            return False
    
    def check_msg(self, timeout=0):
        """
        非阻塞检查消息
        
        Args:
            timeout: 超时时间（毫秒），0 表示非阻塞
        
        Returns:
            bool: 是否有消息
        """
        if not self.connected:
            return False
        
        try:
            # 非阻塞检查
            if timeout == 0:
                self.client.check_msg()
            else:
                self.client.wait_msg()
            return True
        except Exception as e:
            print(f"[MQTT] Check message failed: {e}")
            self.connected = False
            return False
    
    def ping(self):
        """
        发送心跳包
        
        Returns:
            bool: 心跳是否成功
        """
        if not self.connected:
            return False
        
        try:
            self.client.ping()
            self.last_ping = time.time()
            return True
        except Exception as e:
            print(f"[MQTT] Ping failed: {e}")
            self.connected = False
            return False
    
    def reconnect(self, max_retries=3, retry_delay=5):
        """
        自动重连
        
        Args:
            max_retries: 最大重试次数
            retry_delay: 重试间隔（秒）
        
        Returns:
            bool: 重连是否成功
        """
        print("[MQTT] Attempting to reconnect...")
        
        # 先断开旧连接
        self.disconnect()
        
        # 重试连接
        for i in range(max_retries):
            print(f"[MQTT] Retry {i+1}/{max_retries}...")
            
            if self.connect():
                # 重新订阅所有主题
                for topic in self.callbacks.keys():
                    self.client.subscribe(topic)
                    print(f"[MQTT] Re-subscribed to: {topic}")
                
                print("[MQTT] Reconnected successfully")
                return True
            
            if i < max_retries - 1:
                time.sleep(retry_delay)
        
        print("[MQTT] Reconnection failed")
        return False
    
    def _on_message(self, topic, msg):
        """
        内部消息回调处理
        
        Args:
            topic: 主题（bytes）
            msg: 消息内容（bytes）
        """
        try:
            # 解码
            topic_str = topic.decode('utf-8')
            msg_str = msg.decode('utf-8')
            
            print(f"[MQTT] Received on {topic_str}: {msg_str[:50]}...")
            
            # 解析 JSON
            try:
                payload = json.loads(msg_str)
            except:
                payload = msg_str
            
            # 调用注册的回调
            if topic_str in self.callbacks:
                self.callbacks[topic_str](topic_str, payload)
            else:
                print(f"[MQTT] No callback for topic: {topic_str}")
                
        except Exception as e:
            print(f"[MQTT] Message handling error: {e}")
    
    def get_status(self):
        """
        获取连接状态
        
        Returns:
            dict: 状态信息
        """
        return {
            "connected": self.connected,
            "broker": self.broker,
            "device_id": self.device_id,
            "last_ping": self.last_ping
        }


# 辅助函数：生成主题名称
def get_topic(device_id, suffix):
    """
    生成标准主题名称
    
    Args:
        device_id: 设备 ID
        suffix: 主题后缀（如 "task/new", "status"）
    
    Returns:
        str: 完整主题名称
    """
    return f"device/{device_id}/{suffix}"
