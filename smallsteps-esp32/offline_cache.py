"""
离线缓存模块
功能：断网时缓存事件，恢复后自动上报
"""

import json
import time
import os

class OfflineCache:
    """离线缓存管理器"""
    
    def __init__(self, cache_file="cache.json", max_size=50):
        """
        初始化离线缓存
        
        Args:
            cache_file: 缓存文件路径
            max_size: 最大缓存事件数
        """
        self.cache_file = cache_file
        self.max_size = max_size
        self.events = []
        
        # 加载现有缓存
        self._load_cache()
        
        print(f"[Cache] Initialized ({len(self.events)} pending events)")
    
    def _load_cache(self):
        """从文件加载缓存"""
        try:
            if self._file_exists(self.cache_file):
                with open(self.cache_file, 'r') as f:
                    data = json.load(f)
                    self.events = data.get("events", [])
                    print(f"[Cache] Loaded {len(self.events)} events from file")
            else:
                self.events = []
                print("[Cache] No existing cache file")
        except Exception as e:
            print(f"[Cache] Load failed: {e}")
            self.events = []
    
    def _save_cache(self):
        """保存缓存到文件"""
        try:
            data = {"events": self.events}
            with open(self.cache_file, 'w') as f:
                json.dump(data, f)
            print(f"[Cache] Saved {len(self.events)} events to file")
            return True
        except Exception as e:
            print(f"[Cache] Save failed: {e}")
            return False
    
    def _file_exists(self, filename):
        """检查文件是否存在"""
        try:
            os.stat(filename)
            return True
        except OSError:
            return False
    
    def _generate_event_id(self):
        """生成事件 ID"""
        return f"evt_{int(time.time())}_{len(self.events)}"
    
    def add_event(self, topic, payload):
        """
        添加事件到缓存
        
        Args:
            topic: MQTT 主题
            payload: 消息内容（dict）
        
        Returns:
            bool: 是否成功
        """
        try:
            # 检查缓存大小
            if len(self.events) >= self.max_size:
                print(f"[Cache] Cache full ({self.max_size}), removing oldest event")
                self.events.pop(0)
            
            # 创建事件
            event = {
                "id": self._generate_event_id(),
                "topic": topic,
                "payload": payload,
                "timestamp": int(time.time()),
                "sent": False
            }
            
            self.events.append(event)
            self._save_cache()
            
            print(f"[Cache] Added event: {topic}")
            return True
            
        except Exception as e:
            print(f"[Cache] Add event failed: {e}")
            return False
    
    def get_pending_events(self):
        """
        获取待发送事件
        
        Returns:
            list: 待发送事件列表
        """
        return [e for e in self.events if not e["sent"]]
    
    def mark_sent(self, event_id):
        """
        标记事件已发送
        
        Args:
            event_id: 事件 ID
        
        Returns:
            bool: 是否成功
        """
        for event in self.events:
            if event["id"] == event_id:
                event["sent"] = True
                self._save_cache()
                print(f"[Cache] Marked event as sent: {event_id}")
                return True
        
        print(f"[Cache] Event not found: {event_id}")
        return False
    
    def clear_sent_events(self):
        """
        清理已发送事件
        
        Returns:
            int: 清理的事件数
        """
        before_count = len(self.events)
        self.events = [e for e in self.events if not e["sent"]]
        after_count = len(self.events)
        
        cleared = before_count - after_count
        if cleared > 0:
            self._save_cache()
            print(f"[Cache] Cleared {cleared} sent events")
        
        return cleared
    
    def clear_old_events(self, days=7):
        """
        清理旧事件
        
        Args:
            days: 保留天数
        
        Returns:
            int: 清理的事件数
        """
        cutoff_time = time.time() - (days * 24 * 60 * 60)
        before_count = len(self.events)
        
        self.events = [e for e in self.events if e["timestamp"] > cutoff_time]
        after_count = len(self.events)
        
        cleared = before_count - after_count
        if cleared > 0:
            self._save_cache()
            print(f"[Cache] Cleared {cleared} old events (>{days} days)")
        
        return cleared
    
    def get_cache_stats(self):
        """
        获取缓存统计
        
        Returns:
            dict: 统计信息
        """
        pending = len(self.get_pending_events())
        sent = len(self.events) - pending
        
        return {
            "total": len(self.events),
            "pending": pending,
            "sent": sent,
            "max_size": self.max_size
        }
