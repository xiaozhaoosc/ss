# # 基础构建阶段：用于构建或准备 Jar 包
# ARG DOCKER_IMAGE_PREFIX
# FROM ${DOCKER_IMAGE_PREFIX}maven:3.9-eclipse-temurin-21 AS builder
# WORKDIR /src

# # 定义构建参数，默认为 false (使用本地 jar)
# ARG USE_BUILD=false

# # 复制整个项目上下文 (假设上下文为 projects/smallsteps-api)
# COPY . .

# # 根据参数决定是编译打包还是使用现有的 jar
# # 1. 如果 USE_BUILD=true，执行 maven 打包
# # 2. 如果 USE_BUILD=false，尝试查找并移动本地的 jar
# RUN if [ "$USE_BUILD" = "true" ]; then \
#     echo "Building from source..." && \
#     mvn clean package -pl smallsteps-admin -am -DskipTests && \
#     # 将构建产物复制到统一位置 \
#     cp smallsteps-admin/target/smallsteps-admin.jar /app.jar; \
#     else \
#     echo "Using local jar..." && \
#     if [ -f "smallsteps-admin/target/smallsteps-admin.jar" ]; then \
#     cp smallsteps-admin/target/smallsteps-admin.jar /app.jar; \
#     else \
#     echo "Error: Local jar 'smallsteps-admin/target/smallsteps-admin.jar' not found. Please build locally or use --build-arg USE_BUILD=true"; \
#     ls -R smallsteps-admin/target || echo "Target dir empty"; \
#     exit 1; \
#     fi; \
#     fi

# 运行阶段
FROM ${DOCKER_IMAGE_PREFIX}eclipse-temurin:21-jdk-jammy
WORKDIR /app

# 设置时区为上海
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 暴露端口
EXPOSE 8080 28080

# 从 builder 阶段复制最终的 jar 包
COPY --from=builder /app.jar app.jar

# 启动命令
ENTRYPOINT ["java", \
    "-Djava.security.egd=file:/dev/./urandom", \
    "-Dserver.port=8080", \
    "-Dfile.encoding=UTF-8", \
    "-XX:+HeapDumpOnOutOfMemoryError", \
    "-XX:+UseZGC", \
    "-jar", "app.jar"]

