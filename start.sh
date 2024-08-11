#!/bin/bash

# Define the script directory
scriptDir=$(dirname "$(readlink -f "$0")")

# Define screen session names and commands
commands=(
    "cd $scriptDir/houdini && python bootstrap.py login"
    "cd $scriptDir/houdini && python bootstrap.py world"
    "cd $scriptDir/dash && python bootstrap.py -c config.py"
    "cd $scriptDir/web && npm run start"
    "cd $scriptDir/snowflake && python main.py"
    "websockify 0.0.0.0:6113 localhost:6112 --key /etc/letsencrypt/live/cphistory.pw/privkey.pem --cert /etc/letsencrypt/live/cphistory.pw/fullchain.pem"
    "websockify 0.0.0.0:9876 localhost:9875 --key /etc/letsencrypt/live/cphistory.pw/privkey.pem --cert /etc/letsencrypt/live/cphistory.pw/fullchain.pem"
)

# Function to start a screen session with a unique name
start_screen_session() {
    local session_name="$1"
    local command="$2"

    # Check if a screen session with this name already exists and terminate it
    screen -S "$session_name" -X quit >/dev/null 2>&1

    # Start a new screen session with the specified name and execute the command
    screen -dmS "$session_name" bash -c "$command"
}

# Loop through each command and start a screen session
for ((i=0; i<${#commands[@]}; i++)); do
    session_name="penguinscreen_$i"
    command="${commands[$i]}"
    start_screen_session "$session_name" "$command"

    # Sleep for 0.3 seconds between starting each screen session
    sleep 0.3
done
