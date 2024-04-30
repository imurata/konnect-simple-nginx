#!/bin/bash
set -x
sudo apt-get install nginx -y
sudo service nginx start
curl localhost:80 | head -n 5
