Build the container:

    docker build -t=http-auth-ldap .

Then run the container:

    docker run -d -v /home/jekyll/private/_site:/var/www -p 8081:80 \
        -e LDAP_BIND_DN=user -e LDAP_BIND_PW=passwd http-auth-ldap
