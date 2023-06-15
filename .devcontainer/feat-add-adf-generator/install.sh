#!/bin/sh
set -e

ADF_GENERATOR_VERSION=${ADFGENERATORVERSION:-undefined}
echo "INSTALLING Yeoman Generator version $ADF_GENERATOR_VERSION"
su $_REMOTE_USER -c "npm install -g yo && npm install -g generator-alfresco-adf-app@$ADF_GENERATOR_VERSION"
