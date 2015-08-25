Do not use custom dockerfile, instead use official postgres image: https://hub.docker.com/_/postgres/

Run command:
 
    $ docker run --name postgres -e POSTGRES_PASSWORD=mysecretpassword -p 5432:5432 -d postgres

