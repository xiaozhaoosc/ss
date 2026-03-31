#ifndef _OFFLINE_STORAGE_H_
#define _OFFLINE_STORAGE_H_

#include <string>
#include <vector>
#include <mutex>

class OfflineStorage {
public:
    static OfflineStorage& GetInstance() {
        static OfflineStorage instance;
        return instance;
    }

    bool Initialize();
    bool StartRecording(const std::string& filename);
    bool WritePacket(const uint8_t* data, size_t len);
    void StopRecording();
    
    std::vector<std::string> GetFileList();
    bool DeleteFile(const std::string& filename);
    std::string GetFilePath(const std::string& filename);

private:
    OfflineStorage() = default;
    ~OfflineStorage() = default;

    std::mutex mutex_;
    FILE* current_file_ = nullptr;
    bool is_initialized_ = false;
    const char* base_path_ = "/spiffs";
};

#endif // _OFFLINE_STORAGE_H_
