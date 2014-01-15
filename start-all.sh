#!/bin/bash

service exim4 start
service mailman start

/usr/local/bin/apache2-fg
