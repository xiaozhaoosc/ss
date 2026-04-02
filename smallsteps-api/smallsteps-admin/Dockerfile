# 基础构建阶段：使用 Maven 构建
FROM maven:3.9-eclipse-temurin-21 AS builder
WORKDIR /src

# 复制整个项目上下文
COPY . .

# 执行 Maven 打包
RUN mvn clean package -pl smallsteps-admin -am -DskipTests && \
    cp smallsteps-admin/target/smallsteps-admin.jar /app.jar

# 运行阶段
FROM eclipse-temurin:21-jdk-jammy
WORKDIR /app

# 创建配置目录并声明为挂载点
RUN mkdir -p /app/config
VOLUME /app/config

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
    "-Dspring.config.additional-location=/app/config/", \
    "-Dfile.encoding=UTF-8", \
    "-XX:+HeapDumpOnOutOfMemoryError", \
    "-XX:+UseZGC", \
    "-jar", "app.jar"]

