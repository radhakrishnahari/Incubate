#!/bin/sh

sudo apt-get update

sudo ufw status
sudo ufw allow 22/tcp
sudo ufw enable
sudo ufw allow 3306/tcp
sudo ufw allow 5432/tcp
sudo service ufw restart
sudo ufw status

sudo apt-get -y install postgresql postgresql-contrib phppgadmin

