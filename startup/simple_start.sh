#!/bin/sh
pkill -9 node
# forever client.js 2>&1 >> /run/robot.log &

NODE_BIN_DIR="/home/ubuntu/.nvm/v0.10.20/bin/node" # "/usr/local/bin/node"
NODE_PATH="/home/ubuntu/.nvm/v0.10.20/lib/node_modules" # "/usr/local/lib/node_modules"            # npm config ls -l    /    find / -name "node_modules"
APPLICATION_DIRECTORY="/home/ubuntu/robot-onboard"
APPLICATION_START="client.js"
LOG="/run/robot-onboard.log"
FOREVER="/home/ubuntu/.nvm/v0.10.20/bin/forever"

$FOREVER -w --watchDirectory $APPLICATION_DIRECTORY --watchIgnorePatterns ".log" -l $LOG --sourceDir $APPLICATION_DIRECTORY -a --minUptime 5000 --spinSleepTime 2000 start $APPLICATION_START

