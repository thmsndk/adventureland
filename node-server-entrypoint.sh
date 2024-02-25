#!/bin/bash

if [ -z $1 ]; then
    echo "server name required"
    exit 1
fi

if [ -z $2 ]; then
    echo "server identifier required"
    exit 1
fi

if [ -z $3 ]; then
    echo "server port required"
    exit 1
fi

# wait a second for the python stuff to come up
sleep 5

# pwd this scripts runs inside /adventureland/node

# make sure that we have a lib folder if it has not been installed
# this installs flask and any future requirements
pip install -t ../lib -r ../requirements.txt

echo "Starting $1 $2 on port $3"
exec node /adventureland/node/server.js $1 $2 $3