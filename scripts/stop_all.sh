#!/bin/bash

# List of services to stop
services=("service1" "service2" "service3")

# Iterate over the services and stop each one
for service in "${services[@]}"; do
  echo "Stopping $service..."

  # Check if the PID file exists
  if [ ! -f "/var/run/$service.pid" ]; then
    echo "PID file for $service does not exist, skipping..."
    continue
  fi
  
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
  # Ensure the kill command was successful
  if kill -0 $pid 2>/dev/null; then
    echo "Waiting for $service to stop..."
    sleep 1
  fi

  if kill -0 $pid 2>/dev/null; then
    echo "$service did not stop successfully"
    continue
  fi
