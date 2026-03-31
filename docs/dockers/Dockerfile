# 基础镜像使用 OpenJDK 21 (Eclipse Temurin)
FROM eclipse-temurin:21-jdk-jammy

# 设置工作目录
WORKDIR /app

# 设置时区为上海
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 暴露端口
EXPOSE 8080

# 启动命令
# 预期 server-0.0.1-SNAPSHOT.jar 和 application.yml 会被挂载到 /app 目录
CMD ["java", "-Dfile.encoding=UTF-8", "-jar", "server-0.0.1-SNAPSHOT.jar", "--spring.config.location=application.yml"]