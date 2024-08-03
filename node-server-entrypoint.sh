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

# Check and copy variables.js
# if [ ! -f ./variables.js ]; then
#     cp ../useful/template.variables.js ./variables.js
#     echo "Copied template.variables.js to variables.js"
# else
#     echo "variables.js already exists, not overwriting."
# fi

# # Check and copy live_variables.js
# if [ ! -f ./live_variables.js ]; then
#     cp ../useful/template.live_variables.js ./live_variables.js
#     echo "Copied template.live_variables.js to live_variables.js"
# else
#     echo "live_variables.js already exists, not overwriting."
# fi

# wait a second for the python stuff to come up
sleep 5

# pwd this scripts runs inside /adventureland/node

# make sure that we have a lib folder if it has not been installed
# this installs flask and any future requirements
#pip install -t ../lib -r ../requirements.txt

echo "Starting $1 $2 on port $3"
exec node /adventureland/node/server.js $1 $2 $3