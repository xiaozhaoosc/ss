## 问题分析
用户希望在构建 Docker 镜像时使用 pom.xml 中定义的版本号，而不是默认的 `latest` 标签。

## 解决方案
1. **查看版本号**：pom.xml 中定义的版本号为 `${revision}`，实际值是 `5.5.2`
2. **修改 docker-compose.yml**：在构建后端镜像时指定版本标签为 pom 中的版本号
3. **更新镜像引用**：确保服务使用指定版本的镜像

## 具体修改
修改 `dockers/docker-compose.yml` 文件：
1. 在 `backend-core` 服务的 `build` 部分添加 `tags` 字段，指定镜像标签为 `small-steps-backend-core:5.5.2`
2. 确保服务引用使用正确的镜像版本

这样构建的 Docker 镜像就会使用 pom.xml 中定义的版本号作为标签，符合用户的要求。