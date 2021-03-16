#! /usr/bin/env bash


echo "Starting Coturn docker service"
docker-compose pull
docker-compose up -d
docker-compose ps

