# services
Bash scripts for setting up common services on Debian 9

# Architecture
This example was based on two fresh Debian9 VMs (Virtualbox 5.0.40), both with 2 network adapters:
* 1 NAT Network in 10.0.2.0/24
* 1 host-only in 192.168.56.0/24 (default DHCP) - for internet connectivity

The NAT Network had VBox's DHCP disabled so one of the VMs could act as the local DHCP server. Also, the DNS server runs along with DNSSEC in the same machine as the DHCP.

## Example /etc/network/interfaces
~~~~
root@debian:/home/valle/services# cat /etc/network/interfaces
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
allow-hotplug enp0s3
auto enp0s8
iface enp0s8 inet dhcp

allow-hotplug enp0s8
auto enp0s3
iface enp0s3 inet static
    address 10.0.2.1
    netmask 255.255.255.0
~~~~
