#!/bin/bash
# VNC 密码管理
# 用法: bash vnc-passwd.sh [show|set|reset]

VNC_PASSWD_FILE="$HOME/.vnc/passwd"
X11VNC_BIN="/home/ken4zhao/.hermes/home/bin/x11vnc"
LIB_DIR="/home/ken4zhao/.hermes/home/lib"
export LD_LIBRARY_PATH="$LIB_DIR:$LD_LIBRARY_PATH"

case "${1:-show}" in
    show)
        echo "📋 VNC 密码信息:"
        echo "   文件: $VNC_PASSWD_FILE"
        if [ -f "$VNC_PASSWD_FILE" ]; then
            echo "   状态: ✅ 已设置"
            echo "   大小: $(stat -c%s "$VNC_PASSWD_FILE") bytes"
            echo ""
            echo "⚠️  密码是加密存储的，无法直接查看"
            echo "   如需查看，用 'set' 命令设置一个已知密码"
        else
            echo "   状态: ❌ 未设置"
        fi
        ;;
    
    set)
        NEW_PASS="${2:-}"
        if [ -z "$NEW_PASS" ]; then
            echo "用法: $0 set <密码>"
            echo "示例: $0 set MyVncPass123"
            exit 1
        fi
        mkdir -p "$(dirname "$VNC_PASSWD_FILE")"
        $X11VNC_BIN -storepasswd "$NEW_PASS" "$VNC_PASSWD_FILE"
        chmod 600 "$VNC_PASSWD_FILE"
        echo "✅ VNC 密码已设置为: $NEW_PASS"
        echo "   文件: $VNC_PASSWD_FILE"
        ;;
    
    reset)
        # 生成随机密码
        NEW_PASS=$(openssl rand -base64 8)
        mkdir -p "$(dirname "$VNC_PASSWD_FILE")"
        $X11VNC_BIN -storepasswd "$NEW_PASS" "$VNC_PASSWD_FILE"
        chmod 600 "$VNC_PASSWD_FILE"
        echo "✅ VNC 密码已重置为: $NEW_PASS"
        echo "   请保存此密码！"
        ;;
    
    *)
        echo "用法: $0 [show|set|reset]"
        echo "  show  - 查看密码文件状态"
        echo "  set   - 设置指定密码"
        echo "  reset - 生成随机密码"
        ;;
esac
