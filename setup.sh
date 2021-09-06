#!/bin/bash

clear
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
echo "============================================"
echo "| Initiating Docker installation..."
echo "============================================"
echo ""
sleep 2

sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt install -y docker-ce

echo ""
echo "Done ✓"
echo "============================================"

##########
# Run Docker without sudo rights
##########
echo ""
echo ""
echo "============================================"
echo "| Running Docker without sudo rights..."
echo "============================================"
echo ""
sleep 2

sudo usermod -aG docker ${USER}
su - ${USER} &

echo ""
echo "Done ✓"
echo "============================================"

##########
# Install Docker-Compose
##########
echo ""
echo ""
echo "============================================"
echo "| Installing Docker Compose v1.29.2..."
echo "============================================"
echo ""
sleep 2

sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo ""
echo "Done ✓"
echo "============================================"

##########
# Setup project variables
##########
echo ""
echo ""
echo "============================================"
echo "| Please enter project related variables..."
echo "============================================"
sleep 2
echo ""
echo "Enter your domain name (e.g. mydomain.com):"

read DNAME

echo ""
echo "Enter your email:"

read EMAIL

echo ""
echo "Enter your desired MYSQL_ROOT_PASSWORD:"

read MYSQL_ROOT_PASSWORD

echo ""
echo "Enter your desired MYSQL_USER:"

read MYSQL_USER

echo ""
echo "Enter your desired MYSQL_PASSWORD:"

read MYSQL_PASSWORD

echo ""
echo "============================================"
echo ""
echo "Please confirm that your project variables are valid to continue"
echo ""
echo "Domain Name: $DNAME"
echo "Email: $EMAIL"
echo "MYSQL_ROOT_PASSWORD: $MYSQL_ROOT_PASSWORD"
echo "MYSQL_USER: $MYSQL_USER"
echo "MYSQL_PASSWORD: $MYSQL_PASSWORD"
echo ""

read -p "Apply changes (y/n)? " choice
case "$choice" in
  y|Y ) echo "Yes! Proceeding now...";;
  n|N ) echo "No! Aborting now...";;
  * ) echo "Invalid input! Aborting now...";;
esac

sed -i "s/YOUR-DOMAIN/$DNAME/g" ./nginx-conf/nginx.conf
sed -i "s/YOUR-DOMAIN/$DNAME/g" docker-compose.yml
sed -i "s/YOUR-EMAIL/$EMAIL/g" docker-compose.yml
touch .env
echo "MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD" >> .env
echo "MYSQL_USER=$MYSQL_USER" >> .env
echo "MYSQL_PASSWORD=$MYSQL_PASSWORD" >> .env
chmod +x ssl_renew.sh
docker-compose up -d

echo ""
echo "Done ✓"
echo "============================================"
echo ""
