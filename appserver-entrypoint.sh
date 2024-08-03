#!/bin/bash

# Debugging output
echo "Current directory: $(pwd)"
echo "Contents of appserver/default_storage: $(ls -l /appserver/default_storage)"
echo "Contents of /appserver/storage: $(ls -l /appserver/storage)"

# Initialize default storage if /storage is empty
if [ -z "$(ls -A /appserver/storage)" ]; then
  echo "Copying over default storage"
  cp -r /appserver/default_storage/* /appserver/storage/
fi

exec python2 /appserver/sdk/dev_appserver.py --storage_path=/appserver/storage/ --blobstore_path=/appserver/storage/blobstore/ --datastore_path=/appserver/storage/db.rdbms --admin_host=0.0.0.0 --host=0.0.0.0 --port=8083 /adventureland/ --require_indexes --skip_sdk_update_check