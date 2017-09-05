# First prepare server by running runServer and then prepare client with runClient.

#!/bin/bash

source utils.sh

if [ "$#" -ne 2 ]; then
	echo "Usage: ./ssh_config.sh IP_REMOTO SENHA_REMOTA"
	exit 1
fi

function runClient {
	# Generate keypair
	ssh-keygen -t rsa -N "$2" -f chave.key

	# Send local pub key to ssh server
	ssh-copy-id -i chave.key root@$1

	# Change server configuration to accept key only
	sshpass -p "1234" scp ssh/sshd_config_key root@$1:/etc/apache2/sshd_config
}

function runServer {
	up
	apt install openssh-server -y

	# Prepare server to receive the key
	sshpass -p "1234" scp ssh/sshd_config_pass root@$1:/etc/apache2/sshd_config

}

printf "[1] Configure ssh server\n[2] Configure client\n"
read $opt
checkRoot

case $opt in
	1) runClient $1 $2
		;;
	2) runServer $1
		;;
esac


