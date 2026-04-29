$env:DB_HOST='10.8.0.1'
$env:DB_PORT='15432'
$env:DB_NAME='smallsteps_db'
$env:DB_USER='smallsteps'
$env:DB_PASS='abdSSsaf#1236548^'
$env:REDIS_HOST='10.8.0.1'
$env:REDIS_PORT='6379'
$env:REDIS_PASS='abdSSsaf#1236548^'
mvn spring-boot:run -pl smallsteps-admin > server_start_local.log 2>&1
