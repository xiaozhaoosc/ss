$env:DB_HOST='localhost'
$env:DB_PORT='15432'
$env:DB_NAME='smallsteps_db'
$env:DB_USER='smallsteps'
$env:DB_PASS='ui123456789~'
$env:REDIS_HOST='localhost'
$env:REDIS_PORT='6379'
$env:REDIS_PASS='ui123456789~'
mvn spring-boot:run -pl smallsteps-admin > server_start_local.log 2>&1
