#!/bin/sh
set -e

echo "Mounting nxcache on a volume, this will improve performance. Remember to not delete the folder manually"
WORKSPACE_FOLDER=${WORKSPACEFOLDER:-$_REMOTE_USER_HOME}

mkdir -p $WORKSPACE_FOLDER/nxcache
chown $_REMOTE_USER:$_REMOTE_USER $WORKSPACE_FOLDER/nxcache