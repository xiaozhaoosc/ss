$env:DB_HOST='192.168.1.21'
$env:DB_PORT='15432'
$env:DB_NAME='smallsteps_db'
$env:DB_USER='smallsteps'
$env:DB_PASS='abdSSsaf#1236548^'
$env:REDIS_HOST='192.168.1.21'
$env:REDIS_PORT='6379'
$env:REDIS_PASS='abdSSsaf#1236548^'
mvn spring-boot:run -pl smallsteps-admin > server_start_v2.log 2>&1
