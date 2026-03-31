#include "mcp_client.h"
#include <esp_log.h>
#include <cJSON.h>
#include "board.h"
#include "mcp_server.h"
#include "application.h"

#define TAG "McpClient"

McpClient& McpClient::GetInstance() {
    static McpClient instance;
    return instance;
}

void McpClient::Initialize(const std::string& url) {
    url_ = url;
    Connect();
}

void McpClient::Connect() {
    auto network = Board::GetInstance().GetNetwork();
    websocket_ = network->CreateWebSocket(3); // 使用通道 3 独立于语音协议
    
    websocket_->OnData([this](const char* data, size_t len, bool binary) {
        if (!binary) {
            ESP_LOGI(TAG, "Received MCP message: %s", data);
            McpServer::GetInstance().ParseMessage(data);
        }
    });

    websocket_->OnDisconnected([this]() {
        ESP_LOGW(TAG, "MCP WebSocket disconnected, retrying in 10s...");
        Application::GetInstance().Schedule([this]() {
            vTaskDelay(pdMS_TO_TICKS(10000));
            this->Connect();
        });
    });

    ESP_LOGI(TAG, "Connecting to external MCP: %s", url_.c_str());
    if (!websocket_->Connect(url_.c_str())) {
        ESP_LOGE(TAG, "Failed to connect to external MCP endpoint");
    }
}

void McpClient::SendMessage(const std::string& message) {
    if (websocket_ && websocket_->IsConnected()) {
        websocket_->Send(message);
    } else {
        ESP_LOGW(TAG, "Cannot send message, MCP client not connected");
    }
}
