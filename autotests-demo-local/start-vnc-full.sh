#!/bin/bash
# 完整 VNC 环境启动脚本
# 启动: Xvfb + 窗口管理器 + x11vnc + websockify/noVNC

X11VNC_BIN="/home/ken4zhao/.hermes/home/bin/x11vnc"
NOVNC_DIR="/home/ken4zhao/Documents/office/jushuang1/github/droidVNC-NG/noVNC"
WEBSOCKIFY_BIN="/home/ken4zhao/.hermes/hermes-agent/venv/bin/websockify"
LIB_DIR="/home/ken4zhao/.hermes/home/lib"

export LD_LIBRARY_PATH="$LIB_DIR:$LD_LIBRARY_PATH"

DISPLAY_NUM=":10"
VNC_PORT=5900
WEB_PORT=8462

# 停止旧进程
echo "🧹 清理旧进程..."
pkill -f "Xvfb $DISPLAY_NUM" 2>/dev/null || true
pkill -f "x11vnc.*$DISPLAY_NUM" 2>/dev/null || true
# 只杀我们自己的 websockify (端口 8462)
pkill -f "websockify.*$WEB_PORT" 2>/dev/null || true
sleep 1

# 启动 Xvfb
echo "🖥️  启动 Xvfb $DISPLAY_NUM (1920x1080)..."
Xvfb $DISPLAY_NUM -screen 0 1920x1080x24 -ac &
sleep 1

# 启动窗口管理器
echo "🪟  启动窗口管理器 (xfwm4)..."
DISPLAY=$DISPLAY_NUM xfwm4 &
sleep 1

# 启动 x11vnc
echo "📡 启动 x11vnc (VNC 端口 $VNC_PORT)..."
$X11VNC_BIN \
    -display $DISPLAY_NUM \
    -forever \
    -shared \
    -noxdamage \
    -repeat \
    -nopw \
    -rfbport $VNC_PORT \
    -bg \
    -o /tmp/x11vnc.log
sleep 1

# 启动 websockify + noVNC
echo "🌐 启动 noVNC (Web 端口 $WEB_PORT)..."
$WEBSOCKIFY_BIN \
    --web="$NOVNC_DIR" \
    "$WEB_PORT" \
    "localhost:$VNC_PORT" \
    > /tmp/novnc.log 2>&1 &
echo $! > /tmp/novnc.pid
sleep 1

# 验证
echo ""
echo "✅ 全部启动完成！"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📺 虚拟显示器: $DISPLAY_NUM"
echo "🌐 VNC 访问: http://localhost:$WEB_PORT/vnc_lite.html"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "运行测试: DISPLAY=$DISPLAY_NUM bash run-tests.sh all headed"
echo ""
echo "进程状态:"
pgrep -a "Xvfb $DISPLAY_NUM" && echo "  Xvfb: ✅" || echo "  Xvfb: ❌"
pgrep -a "x11vnc" && echo "  x11vnc: ✅" || echo "  x11vnc: ❌"
pgrep -a "websockify" && echo "  websockify: ✅" || echo "  websockify: ❌"
pgrep -a "xfwm4" && echo "  xfwm4: ✅" || echo "  xfwm4: ❌"

# 保持前台运行以观察输出
echo ""
echo "按 Ctrl+C 退出（后台服务不受影响）"
wait
