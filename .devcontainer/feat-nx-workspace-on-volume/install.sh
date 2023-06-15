#!/bin/sh
set -e

echo "Mounting nxcache and .angular on a volume, this will improve performance. Remember to not delete the folder manually and use rm -rf node_module/* instead"
WORKSPACE_FOLDER=${WORKSPACEFOLDER:-$_REMOTE_USER_HOME}

mkdir -p $WORKSPACE_FOLDER/nxcache $WORKSPACE_FOLDER/.angular 
chown $_REMOTE_USER:$_REMOTE_USER $WORKSPACE_FOLDER/nxcache $WORKSPACE_FOLDER/.angular 