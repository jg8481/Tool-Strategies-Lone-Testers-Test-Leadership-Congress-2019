#!/bin/bash


clear
docker-compose build
docker-compose up
docker stop $(docker ps -a -q) &&
docker rm $(docker ps -a -q)
