#!/bin/bash
# ============================================
# VNC 安全启动脚本
# 用法: bash start-vnc.sh [start|stop|status|secure]
# ============================================

set -e

# ── 配置 ──────────────────────────────────
X11VNC_BIN="/home/ken4zhao/.hermes/home/bin/x11vnc"
NOVNC_DIR="/home/ken4zhao/Documents/office/jushuang1/github/droidVNC-NG/noVNC"
WEBSOCKIFY_BIN="/home/ken4zhao/.hermes/hermes-agent/venv/bin/websockify"
LIB_DIR="/home/ken4zhao/.hermes/home/lib"

VNC_PORT=5910
WEB_PORT=8462
BIND_ADDR="0.0.0.0"
DISPLAY_NUM=:10
VNC_PASSWD="$HOME/.vnc/passwd"

export LD_LIBRARY_PATH="$LIB_DIR:$LD_LIBRARY_PATH"

generate_vnc_password() {
    if [ ! -f "$VNC_PASSWD" ]; then
        echo "🔐 生成 VNC 密码..."
        mkdir -p "$(dirname "$VNC_PASSWD")"
        $X11VNC_BIN -storepasswd "$(openssl rand -base64 12)" "$VNC_PASSWD"
        chmod 600 "$VNC_PASSWD"
        echo "✅ 密码已保存: $VNC_PASSWD"
    fi
}

start_vnc() {
    echo "🖥️  启动 VNC 服务（安全模式）..."
    
    generate_vnc_password
    stop_vnc 2>/dev/null || true
    
    # x11vnc（后台运行，-bg 模式，不用 -loop）
    echo "  → x11vnc (port $VNC_PORT, display $DISPLAY_NUM)"
    $X11VNC_BIN \
        -display $DISPLAY_NUM \
        -forever \
        -shared \
        -noxdamage \
        -repeat \
        -rfbauth "$VNC_PASSWD" \
        -rfbport $VNC_PORT \
        -localhost \
        -bg \
        -o /tmp/x11vnc.log
    sleep 1
    
    # noVNC（websockify）
    echo "  → noVNC (http://$BIND_ADDR:$WEB_PORT)"
    $WEBSOCKIFY_BIN \
        --web="$NOVNC_DIR" \
        --heartbeat=30 \
        "$BIND_ADDR:$WEB_PORT" \
        "localhost:$VNC_PORT" \
        > /tmp/novnc.log 2>&1 &
    echo $! > /tmp/novnc.pid
    sleep 1
    
    # 验证
    if pgrep -f "x11vnc" > /dev/null && pgrep -f "websockify" > /dev/null; then
        echo ""
        echo "✅ VNC 服务已启动（安全模式）"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo "🌐 访问地址:"
        echo "   http://$(hostname -I | awk '{print $1}'):$WEB_PORT/vnc_lite.html"
        echo "   http://10.8.0.3:$WEB_PORT/vnc_lite.html"
        echo ""
        echo "🔐 密码文件: $VNC_PASSWD"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    else
        echo "❌ 启动失败，检查日志:"
        echo "   tail -20 /tmp/x11vnc.log"
        echo "   tail -20 /tmp/novnc.log"
    fi
}

stop_vnc() {
    echo "🛑 停止 VNC 服务..."
    if [ -f /tmp/novnc.pid ]; then
        kill $(cat /tmp/novnc.pid) 2>/dev/null && echo "  → noVNC stopped"
        rm -f /tmp/novnc.pid
    fi
    pkill -f "x11vnc.*$DISPLAY_NUM" 2>/dev/null && echo "  → x11vnc stopped" || echo "  → x11vnc not running"
    pkill -f "websockify.*$WEB_PORT" 2>/dev/null && echo "  → websockify stopped" || true
    echo "✅ VNC 服务已停止"
}

status_vnc() {
    echo "📊 VNC 服务状态:"
    pgrep -f "x11vnc" > /dev/null && echo "  x11vnc: ✅ running" || echo "  x11vnc: ❌ not running"
    pgrep -f "websockify" > /dev/null && echo "  noVNC:  ✅ running" || echo "  noVNC:  ❌ not running"
    echo "  端口: VNC=$VNC_PORT, Web=$WEB_PORT"
}

show_security_tips() {
    echo ""
    echo "🔒 VNC 安全最佳实践"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "✅ 已应用:"
    echo "   • 虚拟显示器 :10（不暴露物理屏幕）"
    echo "   • 密码认证（rfbauth）"
    echo "   • x11vnc 仅监听 localhost"
    echo "   • 非常用端口（5910/8462）"
    echo ""
    echo "📋 建议额外措施:"
    echo "   1. SSH 隧道: ssh -L 8462:localhost:8462 user@server"
    echo "   2. SSL/TLS: websockify --cert=cert.pem --key=key.pem ..."
    echo "   3. 防火墙: ufw allow from 192.168.1.0/24 to any port 8462"
    echo "   4. 定期换密码: rm ~/.vnc/passwd && bash $0 start"
    echo ""
}

case "${1:-start}" in
    start) start_vnc ;;
    stop) stop_vnc ;;
    status) status_vnc ;;
    secure) show_security_tips ;;
    *) echo "用法: $0 [start|stop|status|secure]"; exit 1 ;;
esac
