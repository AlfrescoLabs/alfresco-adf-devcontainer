#!/bin/sh
set -e

WORKSPACE_FOLDER=${WORKSPACEFOLDER:-$_REMOTE_USER_HOME}

echo "mounting node_modules and angular volumes"
mkdir -p $WORKSPACE_FOLDER/node_modules $WORKSPACE_FOLDER/.angular
chown $_REMOTE_USER:$_REMOTE_USER $WORKSPACE_FOLDER/node_modules $WORKSPACE_FOLDER/.angular 
