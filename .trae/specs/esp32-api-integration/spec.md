# Small Steps ESP32 与 API 接口集成 - 产品需求文档

## Overview
- **Summary**: 本文档定义了 Small Steps 项目中 ESP32 硬件终端与后端 API 服务之间的接口开发、联调对接、测试与问题修复的完整计划。
- **Purpose**: 确保 ESP32 硬件终端能够与后端 API 服务进行稳定、高效的通信，实现完整的功能闭环。
- **Target Users**: 开发团队、测试团队、产品团队

## Goals
- 设计并实现 ESP32 与 API 之间的通信接口
- 完成两者之间的联调对接
- 制定并执行全面的测试计划
- 修复测试过程中发现的问题
- 执行 5 轮测试回滚验证

## Non-Goals (Out of Scope)
- 硬件硬件设计与制造
- 前端应用开发
- 后端业务逻辑的修改
- 第三方服务集成

## Background & Context
- Small Steps 项目包含 ESP32 硬件终端、后端 API 服务、前端应用三个主要组件
- ESP32 终端需要与后端 API 进行数据交互，实现任务同步、状态上报等功能
- 目前两个系统独立开发，需要建立稳定的通信机制

## Functional Requirements
- **FR-1**: ESP32 终端能够通过 MQTT/WebSocket 与 API 服务建立连接
- **FR-2**: ESP32 终端能够上报设备状态和传感器数据
- **FR-3**: ESP32 终端能够接收并执行来自 API 的任务指令
- **FR-4**: API 服务能够处理 ESP32 终端的请求并返回响应
- **FR-5**: 系统能够处理网络异常和重连机制

## Non-Functional Requirements
- **NFR-1**: 通信延迟 < 500ms
- **NFR-2**: 系统可靠性 > 99.9%
- **NFR-3**: 数据传输安全性（加密传输）
- **NFR-4**: 系统可扩展性（支持多设备并发）

## Constraints
- **Technical**: ESP32 硬件资源有限，需要优化通信协议
- **Business**: 项目时间紧迫，需要在 2 周内完成集成
- **Dependencies**: 依赖 MQTT  broker 或 WebSocket 服务

## Assumptions
- ESP32 硬件终端已完成基本功能开发
- API 服务已完成核心业务逻辑开发
- 网络环境稳定，能够支持 MQTT/WebSocket 通信

## Acceptance Criteria

### AC-1: 通信连接建立
- **Given**: ESP32 终端和 API 服务正常运行
- **When**: ESP32 终端启动并尝试连接 API 服务
- **Then**: 连接成功建立，能够进行数据传输
- **Verification**: `programmatic`

### AC-2: 设备状态上报
- **Given**: ESP32 终端与 API 服务已建立连接
- **When**: ESP32 终端采集到状态数据
- **Then**: 数据成功上报到 API 服务，API 服务正确处理
- **Verification**: `programmatic`

### AC-3: 任务指令接收
- **Given**: ESP32 终端与 API 服务已建立连接
- **When**: API 服务发送任务指令
- **Then**: ESP32 终端正确接收并执行指令
- **Verification**: `programmatic`

### AC-4: 网络异常处理
- **Given**: ESP32 终端与 API 服务已建立连接
- **When**: 网络中断后恢复
- **Then**: ESP32 终端自动重连，恢复通信
- **Verification**: `programmatic`

### AC-5: 5 轮测试回滚
- **Given**: 系统已完成集成
- **When**: 执行 5 轮完整的测试回滚
- **Then**: 每轮测试都能正常通过，系统稳定运行
- **Verification**: `programmatic`

## Open Questions
- [ ] 具体使用 MQTT 还是 WebSocket 作为通信协议？
- [ ] 设备认证和授权机制如何实现？
- [ ] 数据加密方案的具体实现细节？