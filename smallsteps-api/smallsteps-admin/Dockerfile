# Build arguments
ARG DOCKER_IMAGE_PREFIX

# 基础镜像使用 OpenJDK 21 (Eclipse Temurin)
FROM swr.cn-north-4.myhuaweicloud.com/ddn-k8s/docker.io/eclipse-temurin:21-jdk-jammy

# 设置工作目录
WORKDIR /app

# 创建配置目录并声明为挂载点
RUN mkdir -p /app/config
VOLUME /app/config

# 设置时区为上海
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 暴露端口
EXPOSE 8080 28080

# 复制 jar 包
# 假设构建上下文是 projects/smallsteps-api
COPY smallsteps-admin/target/smallsteps-admin.jar app.jar

# 启动命令
ENTRYPOINT ["java", \
    "-Djava.security.egd=file:/dev/./urandom", \
    "-Dserver.port=8080", \
    "-Dspring.config.additional-location=/app/config/", \
    "-Dfile.encoding=UTF-8", \
    "-XX:+HeapDumpOnOutOfMemoryError", \
    "-XX:+UseZGC", \
    "-jar", "app.jar"]

