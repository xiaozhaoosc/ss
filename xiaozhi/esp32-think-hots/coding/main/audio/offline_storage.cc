#include "offline_storage.h"
#include <esp_spiffs.h>
#include <esp_log.h>
#include <dirent.h>
#include <sys/stat.h>

#define TAG "OfflineStorage"

bool OfflineStorage::Initialize() {
    std::lock_guard<std::mutex> lock(mutex_);
    if (is_initialized_) return true;

    esp_vfs_spiffs_conf_t conf = {
        .base_path = base_path_,
        .partition_label = "storage",
        .max_files = 5,
        .format_if_mount_failed = true
    };

    esp_err_t ret = esp_vfs_spiffs_register(&conf);
    if (ret != ESP_OK) {
        if (ret == ESP_FAIL) {
            ESP_LOGE(TAG, "Failed to mount or format filesystem");
        } else if (ret == ESP_ERR_NOT_FOUND) {
            ESP_LOGE(TAG, "Failed to find SPIFFS partition \"storage\"");
        } else {
            ESP_LOGE(TAG, "Failed to initialize SPIFFS (%s)", esp_err_to_name(ret));
        }
        return false;
    }

    size_t total = 0, used = 0;
    ret = esp_spiffs_info("storage", &total, &used);
    if (ret != ESP_OK) {
        ESP_LOGE(TAG, "Failed to get SPIFFS partition information (%s)", esp_err_to_name(ret));
    } else {
        ESP_LOGI(TAG, "Partition size: total: %d, used: %d", total, used);
    }

    is_initialized_ = true;
    return true;
}

bool OfflineStorage::StartRecording(const std::string& filename) {
    std::lock_guard<std::mutex> lock(mutex_);
    if (!is_initialized_) {
        ESP_LOGE(TAG, "Not initialized");
        return false;
    }

    if (current_file_ != nullptr) {
        fclose(current_file_);
    }

    std::string full_path = std::string(base_path_) + "/" + filename;
    current_file_ = fopen(full_path.c_str(), "wb");
    if (current_file_ == nullptr) {
        ESP_LOGE(TAG, "Failed to open file for writing: %s", full_path.c_str());
        return false;
    }

    ESP_LOGI(TAG, "Started recording to %s", full_path.c_str());
    return true;
}

bool OfflineStorage::WritePacket(const uint8_t* data, size_t len) {
    std::lock_guard<std::mutex> lock(mutex_);
    if (current_file_ == nullptr) return false;

    uint16_t packet_len = (uint16_t)len;
    if (fwrite(&packet_len, sizeof(packet_len), 1, current_file_) != 1) {
        return false;
    }
    size_t written = fwrite(data, 1, len, current_file_);
    return written == len;
}

void OfflineStorage::StopRecording() {
    std::lock_guard<std::mutex> lock(mutex_);
    if (current_file_ != nullptr) {
        fclose(current_file_);
        current_file_ = nullptr;
        ESP_LOGI(TAG, "Stopped recording");
    }
}

std::vector<std::string> OfflineStorage::GetFileList() {
    std::lock_guard<std::mutex> lock(mutex_);
    std::vector<std::string> files;
    DIR* dir = opendir(base_path_);
    if (dir == nullptr) return files;

    struct dirent* ent;
    while ((ent = readdir(dir)) != nullptr) {
        if (ent->d_type == DT_REG) {
            files.push_back(ent->d_name);
        }
    }
    closedir(dir);
    return files;
}

bool OfflineStorage::DeleteFile(const std::string& filename) {
    std::lock_guard<std::mutex> lock(mutex_);
    std::string full_path = std::string(base_path_) + "/" + filename;
    return remove(full_path.c_str()) == 0;
}

std::string OfflineStorage::GetFilePath(const std::string& filename) {
    return std::string(base_path_) + "/" + filename;
}
