docker run -d \
  -e MCDAWEB_DB_DRIVER=org.postgresql.Driver \
  -e MCDAWEB_DB_URL=jdbc:postgresql://172.17.42.1/mcdaweb \
  -e MCDAWEB_DB_USERNAME=mcdaweb \
  -e MCDAWEB_DB_PASSWORD=develop \
  -e MCDAWEB_OAUTH_GOOGLE_SECRET=w0rp7-_Z_JQk_T0YcvMe3Aky \
  -e MCDAWEB_OAUTH_GOOGLE_KEY=501575320185-sjffuboubldeaio8ngl1hrgfdj5a2nia.apps.googleusercontent.com \
  -p 8080:8080 -p 2222:22 tomcat
