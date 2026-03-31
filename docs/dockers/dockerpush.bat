@echo off
:: 防止中文乱码，切换控制台为 UTF-8 编码
chcp 65001 >nul

set REGISTRY=registry.cn-shanghai.aliyuncs.com
set NAMESPACE=ken_projects

echo ========================================================
echo        开始批量处理 Docker 镜像 (Aliyun ACR)
echo ========================================================
echo.

:: --------------------------------------------------
:: 1. MinIO
:: --------------------------------------------------
echo [1/6] 正在处理 MinIO...
docker tag minio/minio:latest %REGISTRY%/%NAMESPACE%/minio:latest
docker push %REGISTRY%/%NAMESPACE%/minio:latest
echo.

:: --------------------------------------------------
:: 2. Nginx
:: --------------------------------------------------
echo [2/6] 正在处理 Nginx...
docker tag nginx:alpine %REGISTRY%/%NAMESPACE%/nginx:alpine
docker push %REGISTRY%/%NAMESPACE%/nginx:alpine
echo.

:: --------------------------------------------------
:: 3. Postgres
:: --------------------------------------------------
echo [3/6] 正在处理 Postgres...
docker tag postgres:15-alpine %REGISTRY%/%NAMESPACE%/postgres:15-alpine
docker push %REGISTRY%/%NAMESPACE%/postgres:15-alpine
echo.

:: --------------------------------------------------
:: 4. RabbitMQ
:: --------------------------------------------------
echo [4/6] 正在处理 RabbitMQ...
docker tag rabbitmq:3-management-alpine %REGISTRY%/%NAMESPACE%/rabbitmq:3-management-alpine
docker push %REGISTRY%/%NAMESPACE%/rabbitmq:3-management-alpine
echo.

:: --------------------------------------------------
:: 5. Redis
:: --------------------------------------------------
echo [5/6] 正在处理 Redis...
docker tag redis:7-alpine %REGISTRY%/%NAMESPACE%/redis:7-alpine
docker push %REGISTRY%/%NAMESPACE%/redis:7-alpine
echo.

:: --------------------------------------------------
:: 6. EMQX
:: --------------------------------------------------
echo [6/6] 正在处理 EMQX...
docker tag emqx/emqx:5.3.0 %REGISTRY%/%NAMESPACE%/emqx:5.3.0
docker push %REGISTRY%/%NAMESPACE%/emqx:5.3.0
echo.

echo ========================================================
echo               所有任务执行完毕！
echo ========================================================
pause