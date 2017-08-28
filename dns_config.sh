# Reference: https://wiki.debian.org/DDNS
# Reference: https://blog.bigdinosaur.org/running-bind9-and-isc-dhcp/
# Reference: https://www.youtube.com/watch?v=Soi18HGtCRY
#!/bin/bash

# implement security: http://www.tldp.org/HOWTO/DNS-HOWTO-6.html
# implement slave dns server

source utils.sh

function hardening {
    chmod 640 /etc/bind/named.conf*
}
checkRoot
up
apt install bind9 bind9-doc -y
genKey
cp dns/named.conf.local /etc/bind/named.conf.local
cp dns/named.conf.options /etc/bind/named.conf.options
cp dns/db.gciber.com /etc/bind/db.gciber.com
cp dns/db.10.0.2 /etc/bind/db.10.0.2 # change IP range. Better yet, move this to a config file

chown bind:bind /etc/bind
/etc/init.d/bind9 restart
