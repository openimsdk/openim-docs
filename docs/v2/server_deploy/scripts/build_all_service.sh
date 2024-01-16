#!/bin/bash

# Change directory to the script directory
cd "$(dirname "$0")"

# Make the batch_build_all_service.sh script executable
chmod +x ./batch_build_all_service.sh

# Execute the batch_build_all_service.sh script
./batch_build_all_service.sh
