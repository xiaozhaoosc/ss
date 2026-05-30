#!/bin/bash
# Small Steps 自动化测试 - 录屏 + VNC 查看
# 用法: bash run-tests-record.sh [ui|app|all] [headed|headless]

set -e

SS_DIR="/home/ken4zhao/Documents/office/jushuang1/github/ss"
DEMO_DIR="$SS_DIR/autotests-demo"
RECORD_DIR="$DEMO_DIR/recordings"
mkdir -p "$RECORD_DIR"

MODE="${1:-all}"
DISPLAY_MODE="${2:-headed}"

# 颜色
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

# 设置 NVM
export NVM_DIR="/home/ken4zhao/.nvm"
source "$NVM_DIR/nvm.sh" 2>/dev/null || true

# 设置显示
if [ "$DISPLAY_MODE" = "headed" ]; then
    export DISPLAY=:10
    echo -e "${BLUE}🖥️  有头模式 (DISPLAY=:10)${NC}"
else
    echo -e "${BLUE}🔇 无头模式${NC}"
fi

TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# 启动录屏 (ffmpeg)
FFMPEG_PID=""
if [ "$DISPLAY_MODE" = "headed" ] && command -v ffmpeg &>/dev/null; then
    RECORD_FILE="$RECORD_DIR/test-run-${TIMESTAMP}.mp4"
    echo -e "${YELLOW}🎬 启动录屏: $RECORD_FILE${NC}"
    ffmpeg -y -f x11grab -video_size 1280x720 -framerate 15 -i :10 \
        -c:v libx264 -preset ultrafast -crf 28 \
        "$RECORD_FILE" </dev/null >/dev/null 2>&1 &
    FFMPEG_PID=$!
    sleep 1
fi

# 启动 VNC 截图服务 (每500ms截图一次，HTTP服务)
VNC_PID=""
if [ "$DISPLAY_MODE" = "headed" ]; then
    SCREENSHOT_DIR="$RECORD_DIR/vnc-screenshots"
    mkdir -p "$SCREENSHOT_DIR"
    
    # 创建截图循环脚本
    cat > /tmp/vnc-screenshot.sh << 'VNCSCRIPT'
#!/bin/bash
DIR="$1"
while true; do
    DISPLAY=:10 import -window root "$DIR/latest.jpg" 2>/dev/null || true
    sleep 0.5
done
VNCSCRIPT
    chmod +x /tmp/vnc-screenshot.sh
    /tmp/vnc-screenshot.sh "$SCREENSHOT_DIR" &
    VNC_PID=$!
    
    # 创建 HTTP 服务器
    cat > /tmp/vnc-server.js << 'VNCSERVER'
const http = require('http');
const fs = require('fs');
const path = require('path');

const dir = process.argv[2];
const port = 9876;

const server = http.createServer((req, res) => {
    if (req.url === '/' || req.url === '/index.html') {
        res.writeHead(200, {'Content-Type': 'text/html'});
        res.end(`<!DOCTYPE html>
<html><head><title>SS Test Live View</title>
<style>body{margin:0;background:#1a1a2e;display:flex;flex-direction:column;align-items:center;padding:20px;font-family:system-ui}
h1{color:#e94560;margin-bottom:10px}
img{max-width:1280px;border:2px solid #e94560;border-radius:8px}
.info{color:#aaa;margin-top:10px;font-size:14px}
</style></head><body>
<h1>🎬 Small Steps 自动化测试 - 实时画面</h1>
<img id="screen" src="/latest.jpg" />
<div class="info">每 500ms 自动刷新 | 按 F5 刷新页面</div>
<script>setInterval(()=>{document.getElementById('screen').src='/latest.jpg?'+Date.now()},500)</script>
</body></html>`);
    } else if (req.url.startsWith('/latest.jpg')) {
        const file = path.join(dir, 'latest.jpg');
        if (fs.existsSync(file)) {
            res.writeHead(200, {'Content-Type': 'image/jpeg', 'Cache-Control': 'no-cache'});
            fs.createReadStream(file).pipe(res);
        } else {
            res.writeHead(404);
            res.end('No screenshot yet');
        }
    } else {
        res.writeHead(404);
        res.end('Not found');
    }
});

server.listen(port, '0.0.0.0', () => {
    console.log(`VNC viewer: http://localhost:${port}`);
});
VNCSERVER
    
    node /tmp/vnc-server.js "$SCREENSHOT_DIR" &
    VNC_PID=$!
    echo -e "${GREEN}👁️  实时查看: http://localhost:9876${NC}"
    sleep 1
fi

# 清理函数
cleanup() {
    echo -e "\n${YELLOW}🧹 清理...${NC}"
    [ -n "$FFMPEG_PID" ] && kill $FFMPEG_PID 2>/dev/null
    [ -n "$VNC_PID" ] && kill $VNC_PID 2>/dev/null
    # Kill screenshot loop
    pkill -f "vnc-screenshot.sh" 2>/dev/null
    pkill -f "vnc-server.js" 2>/dev/null
    
    if [ -n "$RECORD_FILE" ] && [ -f "$RECORD_FILE" ]; then
        echo -e "${GREEN}📹 录屏文件: $RECORD_FILE${NC}"
    fi
}
trap cleanup EXIT

# 运行测试
run_tests() {
    local dir="$1"
    local label="$2"
    echo ""
    echo -e "${BLUE}━━━ $label: $3 测试 ━━━${NC}"
    cd "$dir"
    npx playwright test --reporter=list 2>&1 || true
}

case "$MODE" in
    ui)
        run_tests "$DEMO_DIR/sats-ui" "DEMO" "管理后台 UI"
        ;;
    app)
        run_tests "$DEMO_DIR/sats-app" "DEMO" "H5 移动端"
        ;;
    all)
        run_tests "$DEMO_DIR/sats-ui" "DEMO" "管理后台 UI"
        run_tests "$DEMO_DIR/sats-app" "DEMO" "H5 移动端"
        ;;
    *)
        echo "用法: $0 [ui|app|all] [headed|headless]"
        exit 1
        ;;
esac

echo ""
echo -e "${GREEN}━━━ 测试完成 ━━━${NC}"
echo "📊 UI 报告: $DEMO_DIR/sats-ui/playwright-report/index.html"
echo "📊 APP 报告: $DEMO_DIR/sats-app/playwright-report/index.html"
[ -n "$RECORD_FILE" ] && echo "📹 录屏: $RECORD_FILE"
