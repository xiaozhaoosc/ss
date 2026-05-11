pipeline {
    agent any

    environment {
        // 项目基本配置
        PROJECT_NAME = "small-steps"
        DOCKER_COMPOSE_FILE = "docker-compose.yml"
        
        // 凭据 ID (需在 Jenkins 系统设置中预先配置)
        // DOCKER_REGISTRY_CREDS = 'aliyun-registry-auth'
    }

    stages {
        stage('1. 环境检查 (Preparation)') {
            steps {
                script {
                    echo "Checking environment..."
                    sh 'docker version'
                    sh 'docker-compose version'
                    sh 'mvn -version'
                    sh 'node -v'
                }
            }
        }

        stage('2. 后端构建 (Backend Build)') {
            steps {
                dir('smallsteps-api') {
                    echo "Building Spring Boot API..."
                    sh 'mvn clean package -DskipTests'
                }
            }
        }

        stage('3. 前端构建 (Frontend UI Build)') {
            steps {
                dir('smallsteps-ui') {
                    echo "Building Web Admin UI..."
                    sh 'npm install'
                    sh 'npm run build'
                }
            }
        }

        stage('4. 移动端构建 (Mobile App Build)') {
            steps {
                dir('smallsteps-app') {
                    echo "Building Mobile Web App..."
                    sh 'npm install'
                    sh 'npm run build:h5'
                }
            }
        }

        stage('5. 容器化部署 (Docker Deploy)') {
            steps {
                script {
                    echo "Deploying via Docker Compose..."
                    // 使用之前创建的 .env 文件或在此处生成
                    sh 'docker-compose down || true'
                    sh 'docker-compose up -d --build'
                }
            }
        }

        stage('6. 健康检查 (Health Check)') {
            steps {
                script {
                    echo "Waiting for services to start..."
                    sleep 30
                    sh 'docker ps'
                    // 简单的 API 连通性测试
                    sh 'curl -f http://localhost:8080/ssapi/auth/info || echo "API not ready yet"'
                }
            }
        }
    }

    post {
        success {
            echo "Successfully deployed Small Steps!"
        }
        failure {
            echo "Deployment failed. Please check the logs."
        }
    }
}
