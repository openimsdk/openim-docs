#!/bin/bash

# List of services to stop
services=("service1" "service2" "service3")

# Iterate over the services and stop each one
for service in "${services[@]}"; do
  echo "Stopping $service..."

  # Read the PID from the file
  pid=$(cat "/var/run/$service.pid")

  # Stop the service
  kill $pid

  # Check if the service was stopped successfully
  if [ $? -ne 0 ]; then
    echo "Failed to stop $service"
    continue
  fi

  echo "$service stopped successfully"
done

echo "All services stopped successfully"
