#!/bin/bash
# VNC 启动脚本（内网模式）
# 用法: bash start-vnc.sh [start|stop|status]

set -e

X11VNC_BIN="/home/ken4zhao/.hermes/home/bin/x11vnc"
NOVNC_DIR="/home/ken4zhao/Documents/office/jushuang1/github/droidVNC-NG/noVNC"
WEBSOCKIFY_BIN="/home/ken4zhao/.hermes/hermes-agent/venv/bin/websockify"
LIB_DIR="/home/ken4zhao/.hermes/home/lib"

VNC_PORT=5900
WEB_PORT=8462
DISPLAY_NUM=:0
AUTH_FILE="/var/run/lightdm/root/:0"

export LD_LIBRARY_PATH="$LIB_DIR:$LD_LIBRARY_PATH"

start_vnc() {
    echo "🖥️  启动 VNC..."
    stop_vnc 2>/dev/null || true
    
    echo "  → x11vnc (display $DISPLAY_NUM)"
    $X11VNC_BIN \
        -display $DISPLAY_NUM \
        -auth $AUTH_FILE \
        -forever \
        -shared \
        -noxdamage \
        -repeat \
        -nopw \
        -rfbport $VNC_PORT \
        -bg \
        -o /tmp/x11vnc.log
    sleep 1
    
    echo "  → noVNC (port $WEB_PORT)"
    $WEBSOCKIFY_BIN \
        --web="$NOVNC_DIR" \
        "$WEB_PORT" \
        "localhost:$VNC_PORT" \
        > /tmp/novnc.log 2>&1 &
    echo $! > /tmp/novnc.pid
    sleep 1
    
    echo ""
    echo "✅ VNC 已启动"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "🌐 http://192.168.50.160:$WEB_PORT/vnc_lite.html"
    echo "🌐 http://10.8.0.3:$WEB_PORT/vnc_lite.html"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
}

stop_vnc() {
    echo "🛑 停止 VNC..."
    [ -f /tmp/novnc.pid ] && kill $(cat /tmp/novnc.pid) 2>/dev/null
    rm -f /tmp/novnc.pid
    pkill -f "x11vnc" 2>/dev/null || true
    pkill -f "websockify" 2>/dev/null || true
    echo "✅ 已停止"
}

status_vnc() {
    pgrep -f "x11vnc" > /dev/null && echo "  x11vnc: ✅" || echo "  x11vnc: ❌"
    pgrep -f "websockify" > /dev/null && echo "  noVNC:  ✅" || echo "  noVNC:  ❌"
}

case "${1:-start}" in
    start) start_vnc ;;
    stop) stop_vnc ;;
    status) status_vnc ;;
    *) echo "用法: $0 [start|stop|status]"; exit 1 ;;
esac
