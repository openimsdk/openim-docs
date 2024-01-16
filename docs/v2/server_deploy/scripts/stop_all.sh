#!/bin/bash

# Change directory to the script directory
cd "$(dirname "$0")"

# Stop all services using docker-compose
docker-compose down
