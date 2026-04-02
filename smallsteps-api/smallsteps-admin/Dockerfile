# Build arguments
ARG DOCKER_IMAGE_PREFIX

# Build Stage
FROM ${DOCKER_IMAGE_PREFIX}maven:3.9-eclipse-temurin-21 AS build
WORKDIR /app

# 复制整个项目
COPY . .

# 构建项目，跳过测试
RUN mvn clean package -pl smallsteps-admin -am -DskipTests

# Runtime Stage
FROM ${DOCKER_IMAGE_PREFIX}eclipse-temurin:21-jdk-jammy
WORKDIR /app

# 创建配置目录并声明为挂载点
RUN mkdir -p /app/config
VOLUME /app/config

# 设置时区为上海
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 暴露端口
EXPOSE 8080 28080

# 从构建阶段复制 jar 包
COPY --from=build /app/smallsteps-admin/target/smallsteps-admin.jar app.jar

# 启动命令
ENTRYPOINT ["java", \
    "-Djava.security.egd=file:/dev/./urandom", \
    "-Dserver.port=8080", \
    "-Dspring.config.additional-location=/app/config/", \
    "-Dfile.encoding=UTF-8", \
    "-XX:+HeapDumpOnOutOfMemoryError", \
    "-XX:+UseZGC", \
    "-jar", "app.jar"]

