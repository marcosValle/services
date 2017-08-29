#Reference: https://geekflare.com/apache-web-server-hardening-security/#21-Remove-Server-Version-Banner
#!/bin/bash

source utils.sh

USR='gciber'
checkRoot
#up

apt install vsftpd

# Add user
echo "Creating user $USR" 
if [[ ! $(checkUserExists $USR) ]]
then
        # Add linux user       
        adduser $USR --gecos ",,," --disabled-password
        echo "$USR:1234" | chpasswd
fi

# Set configurations. Please double check before applying.
cp ftp/vsftpd.conf /etc/vsftpd.conf

# Set right permissions to chrooted folder (might want to create a specific user)
chmod a-w /home/gciber/

# Generate TLS certificate
openssl req -x509 -days 365 -newkey rsa:2048 -nodes -keyout /etc/vsftpd.pem -out /etc/vsftpd.pem 

systemctl restart vsftpd.service
