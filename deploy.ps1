# Small Steps Automated Deployment Script

$ErrorActionPreference = "Stop"

Write-Host "--- [Small Steps] Starting Automated Deployment ---" -ForegroundColor Cyan

# 1. Check Docker
if (!(Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-Error "Docker is not installed or not in PATH."
}
if (!(Get-Command docker-compose -ErrorAction SilentlyContinue)) {
    Write-Error "Docker Compose is not installed or not in PATH."
}

# 2. Build and Start
Write-Host "Step 1: Building and starting containers..." -ForegroundColor Yellow
docker-compose up -d --build

# 3. Wait for services
Write-Host "Step 2: Waiting for services to initialize (30s)..." -ForegroundColor Yellow
Start-Sleep -Seconds 30

# 4. Verification
Write-Host "Step 3: Verifying deployment status..." -ForegroundColor Yellow
docker-compose ps

$apiStatus = curl -s http://localhost:8080/ssapi/auth/info
if ($apiStatus) {
    Write-Host "[SUCCESS] API is reachable." -ForegroundColor Green
} else {
    Write-Host "[WARNING] API is not responding yet. Check 'docker logs ss-api'." -ForegroundColor Red
}

$uiStatus = curl -s -I http://localhost:80
if ($uiStatus -match "200 OK") {
    Write-Host "[SUCCESS] Web UI is reachable." -ForegroundColor Green
} else {
    Write-Host "[WARNING] Web UI is not responding yet. Check 'docker logs ss-ui'." -ForegroundColor Red
}

Write-Host "--- [Small Steps] Deployment Finished ---" -ForegroundColor Cyan
Write-Host "Web Admin UI: http://localhost:80"
Write-Host "Mobile Web App: http://localhost:81"
Write-Host "API Base URL: http://localhost:8080/ssapi"
