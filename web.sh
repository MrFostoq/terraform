#!/bin/bash
apt update
apt install wget unzip apache2 -y
systemctl start apache2
systemctl enable apache2
wget https://www.tooplate.com/zip-templates/2136_kool_form_pack.zip
unzip -o 2136_kool_form_pack.zip
cp -r 2136_kool_form_pack/* /var/www/html/
systemctl restart apache2