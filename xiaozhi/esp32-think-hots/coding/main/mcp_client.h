#ifndef _MCP_CLIENT_H_
#define _MCP_CLIENT_H_

#include <string>
#include <memory>
#include <web_socket.h>

class McpClient {
public:
    static McpClient& GetInstance();
    
    void Initialize(const std::string& url);
    void SendMessage(const std::string& message);

private:
    McpClient() = default;
    
    std::string url_;
    std::unique_ptr<WebSocket> websocket_;
    
    void Connect();
};

#endif // _MCP_CLIENT_H_
