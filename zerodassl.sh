#!/bin/bash
# Descripción: mini script para la instalación de Let's encrypt en directadmin.
#Author: Juan Rangel



echo "++++++++++++++++++++++++++++++++++++"
echo "Install Let's Encrypt"
echo "++++++++++++++++++++++++++++++++++++"

echo "Changin DirectAdmin enviroment"
echo "action=directadmin&value=restart" >> /usr/local/directadmin/data/task.queue; /usr/local/directadmin/dataskq d2000
echo "changes on email conf"
echo mail_sni=1 >> /usr/local/directadmin/conf/directadmin.conf
echo "Rebuilding confs"
/usr/local/directadmin/custombuild/build rewrite_confs
echo "Disabling mod ruid"
sed -i -r -e '/^mod_ruid2.*/s/yes/no/' /usr/local/directadmin/custombuild/options.conf 

echo "Updating"
/usr/local/directadmin/custombuild/build update


echo "instaling Let's encrypt and updating apache:"
/usr/local/directadmin/custombuild/build letsencrypt
/usr/local/directadmin/custombuild/build apache

echo "updating exim version"
/usr/local/directadmin/custombuild/build set eximconf yes
/usr/local/directadmin/custombuild/build set eximconf_release 4.5
/usr/local/directadmin/custombuild/build set dovecot_conf yes
/usr/local/directadmin/custombuild/build exim_conf
/usr/local/directadmin/custombuild/build dovecot_conf

echo "messing up with directadmin.conf file"
echo "letsencrypt=1" >> /usr/local/directadmin/conf/directadmin.conf

echo "restarting Direct admin service"
service directadmin restart
