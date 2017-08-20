#!/bin/bash

source utils.sh

checkRoot
up
apt install isc-dhcp-server
cp dhcp/dhcpd.conf /etc/dhcp/dhcpd.conf
cp dhcp/isc-dhcp-server /etc/default/
/etc/init.d/isc-dhcp-server restart
