#!/bin/bash

COMPOSE="/usr/local/bin/docker-compose --no-ansi"
DOCKER="/usr/bin/docker"

CURRENT_PATH="$(realpath .)"
cd YOUR-CURRENT-PATH
cd $(echo $CURRENT_PATH | tr -d '\r')

$COMPOSE run certbot renew && $COMPOSE kill -s SIGHUP webserver
$DOCKER system prune -af
