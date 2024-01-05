#!/bin/bash

# List of services to build
services=("service1" "service2" "service3")

# Iterate over the services and build each one
for service in "${services[@]}"; do
  echo "Building $service..."
  
  # Navigate to the service's directory
  cd $service
  
  # Build the service
  go build .
  
  # Check if the build was successful
  if [ $? -ne 0 ]; then
    echo "Failed to build $service"
    exit 1
  fi
  
  # Navigate back to the scripts directory
  cd ..
  
  echo "$service built successfully"
done

echo "All services built successfully"
