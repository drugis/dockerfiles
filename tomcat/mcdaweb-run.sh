MCDAWEB_DB_DRIVER=org.postgresql.Driver
MCDAWEB_DB_URL=jdbc:postgresql://172.17.42.1/mcdaweb
MCDAWEB_DB_USERNAME=mcdaweb
MCDAWEB_DB_PASSWORD=develop

docker run -d -name mcdaweb \
  -e JAVA_OPTS="-DMCDAWEB_DB_DRIVER=$MCDAWEB_DB_DRIVER -DMCDAWEB_DB_URL=$MCDAWEB_DB_URL -DMCDAWEB_DB_USERNAME=$MCDAWEB_DB_USERNAME -DMCDAWEB_DB_PASSWORD=$MCDAWEB_DB_PASSWORD -DtomcatProxyScheme=http -DtomcatProxyName=localhost -DtomcatProxyPort=8081" \
  -e MCDAWEB_OAUTH_GOOGLE_SECRET=w0rp7-_Z_JQk_T0YcvMe3Aky \
  -e MCDAWEB_OAUTH_GOOGLE_KEY=501575320185-sjffuboubldeaio8ngl1hrgfdj5a2nia.apps.googleusercontent.com \
  -p 8081:8080 -p 2222:22 tomcat
