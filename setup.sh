#!/bin/bash

echo ""
echo "============================================"
echo "|                                          |"
echo "|  Wordpress+Nginx+FPM+MySQL+Docker Setup  |"
echo "|          by Theofilos Chamalis           |"
echo "|                                          |"
echo "============================================"
sleep 2

#########
# Install Docker
#########
echo ""
echo "Initiating Docker installation..."
sleep 2
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt install docker-ce
echo "done!"

##########
# Run Docker without sudo rights
##########
echo ""
echo "Running Docker without sudo rights..."
sleep 2
sudo usermod -aG docker ${USER}
su - ${USER}
echo "done!"

##########
# Install Docker-Compose
##########
echo ""
echo "Installing Docker Compose v1.29.2..."
sleep 2
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
echo "done!"

##########
# Setup project variables
##########
echo ""
echo "Prepare to enter project related variables..."
sleep 2
echo ""
echo "Enter your domain name (e.g. mydomain.com):"
read DNAME
sleep 1
echo "done!"
echo ""
echo "Retrieving current path..."
CURRENT_PATH="$(realpath .)"
sleep 1
echo "done!"
echo ""
echo "Enter your desired MYSQL_ROOT_PASSWORD:"
read MYSQL_ROOT_PASSWORD
sleep 1
echo "done!"
echo ""
echo "Enter your desired MYSQL_USER:"
read MYSQL_USER
sleep 1
echo "done!"
echo ""
echo "Enter your desired MYSQL_PASSWORD:"
read MYSQL_PASSWORD
sleep 1
echo "done!"
echo ""
echo "Please confirm that your project variables are valid to continue"
echo "Domain Name: $DNAME"
echo "Current Path: $CURRENT_PATH"
echo "MYSQL_ROOT_PASSWORD: $MYSQL_ROOT_PASSWORD"
echo "MYSQL_USER: $MYSQL_USER"
echo "MYSQL_PASSWORD: $MYSQL_PASSWORD"
echo ""
read -p "Apply changes (y/n)?" choice
case "$choice" in 
  y|Y ) echo "Yes! Proceeding now...";;
  n|N ) echo "No! Aborting now...";;
  * ) echo "Invalid input! Aborting now...";;
esac
