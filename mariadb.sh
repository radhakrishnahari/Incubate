#!/bin/sh

sudo apt-get update

sudo ufw status
sudo ufw allow 22/tcp
sudo ufw enable
sudo ufw allow 3306/tcp
sudo service ufw restart
sudo ufw status


#
# Install .net core
#
sudo apt-get install curl
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-zesty-prod zesty main" > /etc/apt/sources.list.d/dotnetdev.list'
sudo apt-get update
sudo apt-get --yes --force-yes install dotnet-sdk-2.0.0
sudo apt-get update

#
# Install MDS hooks
#repoPkg=azure-repoclient-https-noauth_0.1.0-2_amd64.deb
#wget --no-check-certificate https://apt-mo.trafficmanager.net/repos/azurecore/pool/main/a/azure-repoclient-https-noauth/$repoPkg
#sudo dpkg -i $repoPkg
#sudo apt-get install $repoPkg
#sudo apt-get install azure-mdsd
#sudo service mdsd restart 
#sudo apt-get update
 
sudo apt-get --yes install mariadb-server
sudo apt-get update

echo << EOT >> /tmp/temp.sql
use mysql
create user 'mariadbadmin'@'%' identified by password 'Yukon900Incubate';
update user set password=PASSWORD('Yukon900Incubate') where user='mariadbadmin';
grant all on *.* to 'mariadbadmin'@'%';
flush privileges;

EOT

sudo mysql < /tmp/temp.sql

cat /etc/mysql/mariadb.conf.d/50-server.cnf | sed 's/bind-address/#bind-address/' > /tmp/50-server.cnf
 