"""
任务管理模块
功能：任务解析、步骤管理、状态跟踪
"""

import time
import json

class Task:
    """任务数据类"""
    
    def __init__(self, task_id, title, steps):
        """
        初始化任务
        
        Args:
            task_id: 任务 ID
            title: 任务标题
            steps: 步骤列表 [{"step_id": 1, "description": "...", "estimated_time": 10}]
        """
        self.task_id = task_id
        self.title = title
        self.steps = steps
        self.current_step = 0  # 0 表示未开始
        self.status = "pending"  # pending, running, paused, completed
        self.start_time = 0
        self.pause_time = 0
        self.total_pause_duration = 0
        self.step_start_times = {}  # step_id -> start_time
        self.step_complete_times = {}  # step_id -> complete_time
    
    def get_current_step(self):
        """获取当前步骤"""
        if self.current_step == 0 or self.current_step > len(self.steps):
            return None
        return self.steps[self.current_step - 1]
    
    def get_progress(self):
        """获取进度百分比"""
        if len(self.steps) == 0:
            return 100
        return int((self.current_step / len(self.steps)) * 100)
    
    def get_elapsed_time(self):
        """获取已用时间（秒）"""
        if self.start_time == 0:
            return 0
        
        if self.status == "paused":
            return self.pause_time - self.start_time - self.total_pause_duration
        else:
            return time.time() - self.start_time - self.total_pause_duration
    
    def to_dict(self):
        """转换为字典"""
        return {
            "task_id": self.task_id,
            "title": self.title,
            "steps": self.steps,
            "current_step": self.current_step,
            "status": self.status,
            "progress": self.get_progress(),
            "elapsed_time": int(self.get_elapsed_time())
        }


class TaskManager:
    """任务管理器"""
    
    def __init__(self):
        """初始化任务管理器"""
        self.current_task = None
        print("[TaskManager] Initialized")
    
    def load_task(self, task_json):
        """
        加载任务
        
        Args:
            task_json: 任务 JSON 数据
                {
                    "task_id": 123,
                    "title": "完成数学作业",
                    "steps": [
                        {"step_id": 1, "description": "准备好练习册和笔", "estimated_time": 2},
                        ...
                    ]
                }
        
        Returns:
            Task: 任务对象
        """
        try:
            task = Task(
                task_id=task_json["task_id"],
                title=task_json["title"],
                steps=task_json.get("steps", [])
            )
            self.current_task = task
            print(f"[TaskManager] Loaded task: {task.title} ({len(task.steps)} steps)")
            return task
        except Exception as e:
            print(f"[TaskManager] Load task failed: {e}")
            return None
    
    def start_task(self):
        """
        开始任务
        
        Returns:
            bool: 是否成功
        """
        if not self.current_task:
            print("[TaskManager] No task to start")
            return False
        
        if self.current_task.status != "pending":
            print(f"[TaskManager] Task already {self.current_task.status}")
            return False
        
        self.current_task.status = "running"
        self.current_task.start_time = time.time()
        self.current_task.current_step = 1
        
        # 记录第一步开始时间
        if len(self.current_task.steps) > 0:
            step_id = self.current_task.steps[0]["step_id"]
            self.current_task.step_start_times[step_id] = time.time()
        
        print(f"[TaskManager] Task started: {self.current_task.title}")
        return True
    
    def complete_step(self):
        """
        完成当前步骤
        
        Returns:
            dict: 步骤完成信息 {"step_id": 1, "next_step": 2, "is_last": False}
                 如果是最后一步，返回 {"step_id": N, "next_step": None, "is_last": True}
        """
        if not self.current_task or self.current_task.status != "running":
            print("[TaskManager] No running task")
            return None
        
        current_step_index = self.current_task.current_step - 1
        if current_step_index >= len(self.current_task.steps):
            print("[TaskManager] No more steps")
            return None
        
        # 记录当前步骤完成时间
        step = self.current_task.steps[current_step_index]
        step_id = step["step_id"]
        self.current_task.step_complete_times[step_id] = time.time()
        
        print(f"[TaskManager] Step {step_id} completed: {step['description']}")
        
        # 检查是否是最后一步
        is_last = (current_step_index == len(self.current_task.steps) - 1)
        
        if is_last:
            # 任务完成
            return {
                "step_id": step_id,
                "next_step": None,
                "is_last": True
            }
        else:
            # 进入下一步
            self.current_task.current_step += 1
            next_step = self.current_task.steps[self.current_task.current_step - 1]
            next_step_id = next_step["step_id"]
            
            # 记录下一步开始时间
            self.current_task.step_start_times[next_step_id] = time.time()
            
            print(f"[TaskManager] Next step: {next_step['description']}")
            
            return {
                "step_id": step_id,
                "next_step": next_step_id,
                "is_last": False
            }
    
    def pause_task(self):
        """
        暂停任务
        
        Returns:
            bool: 是否成功
        """
        if not self.current_task or self.current_task.status != "running":
            print("[TaskManager] No running task to pause")
            return False
        
        self.current_task.status = "paused"
        self.current_task.pause_time = time.time()
        
        print(f"[TaskManager] Task paused")
        return True
    
    def resume_task(self):
        """
        恢复任务
        
        Returns:
            bool: 是否成功
        """
        if not self.current_task or self.current_task.status != "paused":
            print("[TaskManager] No paused task to resume")
            return False
        
        # 累加暂停时长
        pause_duration = time.time() - self.current_task.pause_time
        self.current_task.total_pause_duration += pause_duration
        
        self.current_task.status = "running"
        
        print(f"[TaskManager] Task resumed (paused for {int(pause_duration)}s)")
        return True
    
    def complete_task(self):
        """
        完成任务
        
        Returns:
            dict: 任务统计信息
        """
        if not self.current_task:
            print("[TaskManager] No task to complete")
            return None
        
        self.current_task.status = "completed"
        
        stats = {
            "task_id": self.current_task.task_id,
            "title": self.current_task.title,
            "total_steps": len(self.current_task.steps),
            "total_time": int(self.current_task.get_elapsed_time()),
            "start_time": int(self.current_task.start_time),
            "complete_time": int(time.time())
        }
        
        print(f"[TaskManager] Task completed: {stats['title']} ({stats['total_time']}s)")
        return stats
    
    def abandon_task(self):
        """
        放弃任务
        
        Returns:
            bool: 是否成功
        """
        if not self.current_task:
            return False
        
        print(f"[TaskManager] Task abandoned: {self.current_task.title}")
        self.current_task = None
        return True
    
    def get_current_step_info(self):
        """
        获取当前步骤信息
        
        Returns:
            dict: 步骤信息
        """
        if not self.current_task:
            return None
        
        step = self.current_task.get_current_step()
        if not step:
            return None
        
        return {
            "step_id": step["step_id"],
            "description": step["description"],
            "estimated_time": step.get("estimated_time", 0),
            "tips": step.get("tips", ""),
            "progress": self.current_task.get_progress()
        }
    
    def get_task_status(self):
        """
        获取任务状态
        
        Returns:
            dict: 任务状态
        """
        if not self.current_task:
            return {"has_task": False}
        
        return {
            "has_task": True,
            "task": self.current_task.to_dict(),
            "current_step_info": self.get_current_step_info()
        }
