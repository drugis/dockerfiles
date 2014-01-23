#!/bin/bash

if [ -z $1 ]; then echo "Please supply a password for the postgres user"; exit 2; fi

docker run -d -p 5432:5432 postgres /usr/local/bin/run-postgresql $1
