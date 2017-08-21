#!/bin/bash

source utils.sh

checkRoot
up
apt install postfix -y

cp smtp/main.cg /etc/postfix/ 

service postfix restart
