#!/bin/bash

source utils.sh

checkRoot

function installDepends {
    apt install build-essential apache2 php openssl perl make php-gd  libapache2-mod-php libperl-dev libssl-dev daemon wget apache2-utils unzip -y
}

function configUser {
    useradd nagios
    groupadd nagcmd
    usermod -a -G nagcmd nagios
    usermod -a -G nagcmd www-data
}

function installNagios {
    cd /tmp
    wget https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.3.2.tar.gz
    tar -zxvf nagios-4.3.2.tar.gz
    cd /tmp/nagios-4.3.2/
    ./configure --with-nagios-group=nagios --with-command-group=nagcmd --with-httpd_conf=/etc/apache2/sites-enabled/
make all
    make install
    make install-init
    make install-config
    make install-commandmode
    make install-webconf
}

function webGui {
    htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin
    a2enmod cgi
    service apache2 restart
}

function installPlugins {
    cd /tmp
    wget https://nagios-plugins.org/download/nagios-plugins-2.2.1.tar.gz
    tar -zxvf /tmp/nagios-plugins-2.2.1.tar.gz
    cd /tmp/nagios-plugins-2.2.1/

    ./configure --with-nagios-user=nagios --with-nagios-group=nagios
    make
    make install
}

function finish {
    /usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg
    /etc/init.d/nagios start
    systemctl enable nagios
}

installDepends
configUser
installNagios
webGui
installPlugins
finish
