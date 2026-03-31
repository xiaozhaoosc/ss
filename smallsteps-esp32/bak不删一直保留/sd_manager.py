from machine import Pin, SPI
import os

class SDManager:
    """
    SD 卡管理器
    
    功能：
    - 初始化 SPI 和 SD 卡
    - 挂载文件系统
    - 提供文件操作接口
    """
    
    def __init__(self, sck_pin, mosi_pin, miso_pin, cs_pin):
        """
        初始化 SD 卡管理器
        
        参数：
            sck_pin: SPI 时钟引脚
            mosi_pin: SPI MOSI 引脚
            miso_pin: SPI MISO 引脚
            cs_pin: 片选引脚
        """
        self.sck_pin = sck_pin
        self.mosi_pin = mosi_pin
        self.miso_pin = miso_pin
        self.cs_pin = cs_pin
        self.mounted = False
        self.mount_point = "/sd"
    
    def mount(self):
        """挂载 SD 卡"""
        try:
            import sdcard
            
            # 初始化 SPI
            spi = SPI(2,
                     baudrate=1000000,
                     polarity=0,
                     phase=0,
                     sck=Pin(self.sck_pin),
                     mosi=Pin(self.mosi_pin),
                     miso=Pin(self.miso_pin))
            
            # 初始化 SD 卡
            sd = sdcard.SDCard(spi, Pin(self.cs_pin))
            
            # 挂载文件系统
            os.mount(sd, self.mount_point)
            self.mounted = True
            
            print("SD card mounted at " + self.mount_point)
            return True
            
        except Exception as e:
            print("Failed to mount SD card: " + str(e))
            return False
    
    def unmount(self):
        """卸载 SD 卡"""
        if self.mounted:
            try:
                os.umount(self.mount_point)
                self.mounted = False
                print("SD card unmounted")
                return True
            except Exception as e:
                print("Failed to unmount SD card: " + str(e))
                return False
        return True
    
    def list_files(self, path="/"):
        """
        列出指定路径下的文件和文件夹
        
        参数：
            path: 相对于挂载点的路径
        
        返回：
            文件和文件夹列表
        """
        if not self.mounted:
            print("SD card not mounted")
            return []
        
        full_path = self.mount_point + path
        try:
            return os.listdir(full_path)
        except Exception as e:
            print("Failed to list files: " + str(e))
            return []
    
    def create_folder(self, folder_name):
        """
        创建文件夹
        
        参数：
            folder_name: 文件夹名称（如 "01"）
        """
        if not self.mounted:
            print("SD card not mounted")
            return False
        
        full_path = self.mount_point + "/" + folder_name
        try:
            os.mkdir(full_path)
            print("Created folder: " + folder_name)
            return True
        except OSError:
            # 文件夹已存在
            return True
        except Exception as e:
            print("Failed to create folder: " + str(e))
            return False
    
    def write_file(self, file_path, data):
        """
        写入文件
        
        参数：
            file_path: 文件路径（如 "/01/001.mp3"）
            data: 文件数据（bytes）
        """
        if not self.mounted:
            print("SD card not mounted")
            return False
        
        full_path = self.mount_point + file_path
        try:
            with open(full_path, 'wb') as f:
                f.write(data)
            print("File written: " + file_path)
            return True
        except Exception as e:
            print("Failed to write file: " + str(e))
            return False
    
    def delete_file(self, file_path):
        """
        删除文件
        
        参数：
            file_path: 文件路径（如 "/01/001.mp3"）
        """
        if not self.mounted:
            print("SD card not mounted")
            return False
        
        full_path = self.mount_point + file_path
        try:
            os.remove(full_path)
            print("File deleted: " + file_path)
            return True
        except Exception as e:
            print("Failed to delete file: " + str(e))
            return False
    
    def get_file_size(self, file_path):
        """
        获取文件大小
        
        参数：
            file_path: 文件路径
        
        返回：
            文件大小（字节）
        """
        if not self.mounted:
            return 0
        
        full_path = self.mount_point + file_path
        try:
            stat = os.stat(full_path)
            return stat[6]  # 文件大小
        except:
            return 0
    
    def ensure_dfplayer_folders(self):
        """
        确保 DFPlayer 所需的文件夹存在
        创建 01-10 文件夹
        """
        for i in range(1, 11):
            folder_name = "{:02d}".format(i)
            self.create_folder(folder_name)
        print("DFPlayer folders ready (01-10)")
