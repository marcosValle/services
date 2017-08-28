#Reference: https://geekflare.com/apache-web-server-hardening-security/#21-Remove-Server-Version-Banner
#!/bin/bash

source utils.sh
SHARE_PATH="/home/share"
USR="gciber"

# check if root
checkRoot

# upDATE and upGRADE system
#up

# Install samba
#apt install samba

# Add user. Note that this user should already exist in /etc/passwd
echo "Creating user $USR"
if [[ ! $(checkUserExists $USR) ]]
then
	# Add linux user
	adduser $USR --gecos ",,," --disabled-password
	echo "$USR:1234" | chpasswd

	# Add user to SMB server
	smbpasswd -a $USR 
fi

# Create share
echo "Creating $SHARE_PATH..."
mkdir -p $SHARE_PATH

# Set conf file. Please check the configurations before applying it.
echo "Setting smb.conf..."
cp smb/smb.conf /etc/samba/smb.conf

# Restart samba service
echo "Restarting samba..."
systemctl restart smbd.service

echo "Samba is up and running!"
