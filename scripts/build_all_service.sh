#!/bin/bash

# Navigate to the directory of the first service
cd ../service1
# Build the first service
docker build -t service1 .

# Navigate back to the root directory
cd ..

# Repeat the above steps for each service
cd ../service2
docker build -t service2 .
cd ..

cd ../service3
docker build -t service3 .
cd ..

# Make the script executable
chmod +x build_all_service.sh
