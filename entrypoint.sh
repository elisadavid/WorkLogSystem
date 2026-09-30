#!/bin/bash
set -e

DB_HOST="${DB_HOST:-mysql}"
DB_PORT="${DB_PORT:-3306}"
DB_NAME="${DB_NAME:-trainee_mgmt}"
DB_USER="${DB_USER:-root}"
DB_PASSWORD="${DB_PASSWORD:-root}"

if [ ! -d "/usr/local/tomcat/webapps/WorkLogSystem" ]; then
  mkdir -p /usr/local/tomcat/webapps
  unzip -q /usr/local/tomcat/webapps/WorkLogSystem.war -d /usr/local/tomcat/webapps/WorkLogSystem
fi

mkdir -p /usr/local/tomcat/webapps/WorkLogSystem/WEB-INF/classes
cat > /usr/local/tomcat/webapps/WorkLogSystem/WEB-INF/classes/Db_MySql.properties <<EOF
driver=com.mysql.cj.jdbc.Driver
url=jdbc:mysql://${DB_HOST}:${DB_PORT}/${DB_NAME}?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC
user=${DB_USER}
password=${DB_PASSWORD}
EOF

exec catalina.sh run
