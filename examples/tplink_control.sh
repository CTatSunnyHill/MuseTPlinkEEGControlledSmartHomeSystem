#!/bin/bash

# Load environment variables from .env file
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi


# Check if an argument is provided
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 [on|off]"
  exit 1
fi

# # Read the token from file
# if [ -f "$TOKEN_FILE" ]; then
#   TOKEN=$(cat "$TOKEN_FILE")
# else
#   echo "Token file not found. Run the Python script to fetch a token."
#   exit 1
# fi


# Set the state based on the argument
if [ "$1" == "on" ]; then
  STATE=1
  echo "Turning device ON..."
elif [ "$1" == "off" ]; then
  STATE=0
  echo "Turning device OFF..."
else
  echo "Invalid argument. Use 'on' or 'off'."
  exit 1
fi

# Execute the curl command to change device state
curl -s "$APP_SERVER_URL?token=$TOKEN" \
  -H "Content-Type: application/json" \
  -d "{\"method\":\"passthrough\",\"params\":{\"deviceId\":\"$DEVICE_ID\",\"requestData\":\"{\\\"system\\\":{\\\"set_relay_state\\\":{\\\"state\\\":$STATE}}}\"}}" \
  | jq .

echo "Device state changed to $1."
