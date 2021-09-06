# Wordpress Nginx FPM MySQL Docker

A setup boilerplate to quickly bootstrap Wordpress + Nginx + PHP-FPM + MySQL using docker compose. The purpose of this repo is to get you started with a modern, performant, reusable and secure way to start a Wordpress website. This repo is based on DO's instructions presented here: https://www.digitalocean.com/community/tutorials/how-to-install-wordpress-with-docker-compose, 
using a more up to date configuration and easy to set up process.

## Quick Start

```bash
# clone repository
https://github.com/Theofilos-Chamalis/wordpress-nginx-fpm-mysql-docker.git

# Run the setup file
cd wordpress-nginx-fpm-mysql-docker && ./setup.sh

# SSL Auto Renewal crontab (Optional)
sudo crontab -e
0 12 * * * /home/your-username/wordpress-nginx-fpm-mysql-docker/ssl_renew.sh >> /var/log/cron.log 2>&1
```
## Managing the docker containers
- `docker ps -a` (Check all containers statuses)
- `docker compose restart` (Restart all containers)
- `docker compose down` (Stop all containers)
- `docker compose up -d` (Start all containers in detached/background mode)

## Override auto-configuration
If you require to use your own configuration for the project, feel free to edit the following files:
1. ~/wordpress-nginx-fpm-mysql-docker/docker-compose.yml --> <b>YOUR-EMAIL</b> , <b>YOUR-DOMAIN</b>
2. ~/wordpress-nginx-fpm-mysql-docker/ssl_renew.sh --> <b>YOUR-CURRENT_PATH</b>
3. ~/wordpress-nginx-fpm-mysql-docker/nginx-conf/nginx.conf --> <b>YOUR-DOMAIN</b>

## Troubleshooting issues with certbot
If running `docker ps -a` returns an **Exited (1)** status for certbot container and the webserver/nginx container is not running, you could perform the following actions:
1. `docker-compose down && docker-compose up --force-recreate --no-deps certbot` to restart the SSL certificate generation process
2. `docker-compose logs certbot` to list out the certbot issue and find for a resolution online
3. Once the issue is resolved, running `docker-compose down && docker-compose up -d` would bring everything back online
