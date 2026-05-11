#!/bin/bash

# Small Steps Jenkins One-Click Deployment Script (Shell Version)
# Usage: bash jenkins_deploy.sh

set -e

echo "--- [Small Steps CI/CD] Starting Deployment ---"

# 1. Backend Build
echo "[Stage 1] Building Backend..."
cd smallsteps-api
mvn clean package -DskipTests
cd ..

# 2. UI Build
echo "[Stage 2] Building Web UI..."
cd smallsteps-ui
npm install --silent
npm run build
cd ..

# 3. App Build
echo "[Stage 3] Building Mobile App..."
cd smallsteps-app
npm install --silent
npm run build:h5
cd ..

# 4. Docker Orchestration
echo "[Stage 4] Orchestrating Containers..."
# Ensure .env exists (fallback to default if missing)
if [ ! -f .env ]; then
    echo "Warning: .env missing, creating from template..."
    cat <<EOF > .env
PROJECT_NAME=small-steps
TZ=Asia/Shanghai
POSTGRES_USER=smallsteps
POSTGRES_PASSWORD=ui123456789~
POSTGRES_DB=smallsteps_db
REDIS_PASSWORD=ui123456789~
EOF
fi

docker-compose down
docker-compose up -d --build

echo "--- [Small Steps CI/CD] Deployment Successful ---"
docker ps --filter "name=ss-"
