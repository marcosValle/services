#!/bin/bash

source utils.sh

function bannerDisable {
    echo "ServerTokens Prod" >> /etc/apache2/apache2.conf
    echo "ServerSignature Off" >> /etc/apache2/apache2.conf
}

checkRoot
up
apt install apache2
#add mod_security
#add fail2ban
bannerDisable
service apache2 restart
