# Reference: https://wiki.debian.org/DDNS
# Reference: https://blog.bigdinosaur.org/running-bind9-and-isc-dhcp/
# Reference: https://www.youtube.com/watch?v=Soi18HGtCRY
#!/bin/bash

# implement security: http://www.tldp.org/HOWTO/DNS-HOWTO-6.html
# implement slave dns server

source utils.sh

function genKey {
    dnssec-keygen -a HMAC-MD5 -b 128 -r /dev/urandom -n USER DDNS_UPDATE
    key=$(sed -n "/Key/p" Kddns_update.*.private | cut -d" " -f2)
    sed -i "s/<key>/$key/" dns/ddns.key
    cp dns/ddns.key /etc/bind/
    cp dns/ddns.key /etc/dhcp/

    chown root:bind /etc/bind/ddns.key
    chown root:root /etc/dhcp/ddns.key

    chmod 640 /etc/bind/ddns.key
    chmod 640 /etc/bind/ddns.key
}

checkRoot
up
apt install bind9 bind9-doc -y
genKey
cp dns/named.conf.local /etc/bind/named.conf.local
cp dns/named.conf.options /etc/bind/named.conf.options
cp dns/db.gciber.com /etc/bind/db.gciber.com
cp dns/db.192 /etc/bind/db.192 # change IP range. Better yet, move this to a config file

chown bind:bind /etc/bind
/etc/init.d/bind9 restart
