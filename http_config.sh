#Reference: https://geekflare.com/apache-web-server-hardening-security/#21-Remove-Server-Version-Banner
#!/bin/bash

source utils.sh

# do not leak Apache version
function bannerDisable {
    #change Header to production only, i.e. Apache
    echo "ServerTokens Prod" >> /etc/apache2/apache2.conf
    #remove the version information from the page generated like 403, 404, 502, etc
    echo "ServerSignature Off" >> /etc/apache2/apache2.conf
}

function createVHosts {
    mkdir -p /var/www/gciber.com/public_html
    mkdir -p /var/www/mvalle.com/public_html

    cp -p http/gciber_index.html /var/www/gciber.com/public_html/index.html
    cp -p http/mvalle_index.html /var/www/mvalle.gciber.com/public_html/index.html

    chown -R www-data:www-data /var/www/gciber.com/public_html
    chown -R www-data:www-data /var/www/mvalle.gciber.com/public_html

    cp http/apache2.conf /etc/apache2/apache2.conf
    cp -r http/sites-available /etc/apache2

    a2ensite gciber.com.conf mvalle.gciber.com.conf
    a2dissite 000-default.conf

    systemctl reload apache2.service
}

checkRoot

chown root:root /etc/apache2
chmod -R 750 /etc/apache2
a2dismod autoindex

cp http/security.conf /etc/apache2/conf-available/security.conf
a2enconf

# enable modsecurity
apt-get install -y modsecurity-crs libapache2-modsecurity
cp /etc/modsecurity/modsecurity.conf-recommended /etc/modsecurity/modsecurity.conf
a2enmod security2

#up
#apt install apache2
#add mod_security
#add fail2ban
bannerDisable
systemctl reload apache2
systemctl restart apache2
