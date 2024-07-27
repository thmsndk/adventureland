#!/bin/bash

# pwd this scripts runs inside /adventureland/node

# Generate config files if they are missing or the one in usefull is newer.
echo "Setting up server secrets & environment"
cp -u ../useful/template.environment.py ../environment.py && \
cp -u ../useful/template.secrets.py ../secrets.py && \
cp -u ../useful/template.variables.js ./variables.js && \
cp -u ../useful/template.live_variables.js ./live_variables.js

exec python2 /appserver/sdk/dev_appserver.py --storage_path=/appserver/storage/ --blobstore_path=/appserver/storage/blobstore/ --datastore_path=/appserver/storage/db.rdbms --admin_host=0.0.0.0 --host=0.0.0.0 --port=8083 /adventureland/ --require_indexes --skip_sdk_update_check