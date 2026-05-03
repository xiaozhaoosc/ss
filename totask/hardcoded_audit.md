# 硬编码部分审计报告 (Hardcoded Audit Report)

## 1. 网络与 API 端点 (Network & API Endpoints)
大部分前端和移动端代码中存在硬编码的 `localhost` 或特定 IP 地址，这些应该通过环境变量配置。

- **smallsteps-ui (Vite Config & Requests)**:
  - `vite.config.ts`: `target: 'http://localhost:8081/ssapi'`
  - `src/utils/request.ts`: 默认 `baseURL` 依赖 `import.meta.env.VITE_APP_BASE_API`，但有些地方存在 fallback。
  - `playwright.config.ts`: `baseURL: 'http://localhost:88'`
- **smallsteps-api (Swagger & Config)**:
  - `SwaggerConfig.java`: 多处硬编码 `http://localhost:8091` 和 `http://localhost:8084`。
  - `application-dev.yml`: `spring.boot.admin.client.url: http://localhost:9090/admin`
- **smallsteps-app (Mobile Fallbacks)**:
  - `src/pages/mine/help/ai-assistant.vue`: `const baseUrl = import.meta.env.VITE_APP_BASE_API || 'http://localhost:8081/ssapi'`
  - `src/pages/child/treehole-chat/index.vue`: `const baseUrl = getBaseUrl() === '/ssapi' ? 'http://localhost:8081/ssapi' : getBaseUrl()`

## 2. 凭据与密钥 (Credentials & Secrets)
部分敏感信息直接硬编码在配置文件中，存在安全风险。

- **smallsteps-esp32 (Firmware)**:
  - `config.py`: 
    - `WIFI_SSID = "ChinaNet-TzdG"`
    - `WIFI_PASS = "zzakxw3v"`
- **smallsteps-api (Backend Config)**:
  - `application-dev.yml`:
    - 数据库密码: `password: ${DB_PASS:abdSSsaf#1236548^}`
    - Redis 密码: `password: ${REDIS_PASS:abdSSsaf#1236548^}`
    - Snail-job Token: `token: "SJ_cKqBTPzCsWA3VyuCfFoccmuIEGXjr5KT"`
    - Gitee Client ID/Secret: `91436b7940090d09c72c7daf85b959cfd5f215d67eea73acbf61b6b590751a98` / `02c6fcfd70342980cd8dd2f2c06c1a350645d76c754d7a264c4e125f9ba915ac`
    - 邮件服务密码占位符: `pass: xxxxxxxxxx`

## 3. UI 国际化 (UI Internationalization - i18n)
`smallsteps-ui` 中存在大量硬编码的中文文本，未进行 i18n 处理。

- **涉及文件**: 大量 `.vue` 文件（超过 300 处匹配）。
- **示例**:
  - `taskWaiting.vue`: "选择申请人", "搜索", "重置", "办理"
  - `myDocument.vue`: "激活", "挂起", "编辑", "删除", "撤销"
  - `processDefinition/index.vue`: "添加", "修改", "部署流程文件"

## 4. 硬件配置 (Hardware Configuration)
- **smallsteps-esp32**:
  - `device.py`: `HardwareConfig` 类中硬编码了所有 GPIO 引脚。虽然在嵌入式开发中常见，但建议抽取到更集中的硬件配置文件中。

## 5. 建议操作 (Next Steps)
1. 将所有 `localhost` 引用替换为环境变量。
2. 将 `smallsteps-esp32` 的 WiFi 信息移至设备配网流程（BLE/NFC）动态获取，而非硬编码。
3. 使用 CI/CD 变量或 Vault 管理后端 Secret，移除配置文件中的默认明文密码。
4. 对 `smallsteps-ui` 进行全面的 i18n 扫描和重构。
