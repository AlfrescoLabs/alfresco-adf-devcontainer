# Dockerfile v 0.3
# default Node version
ARG NODE_VERSION=14-bullseye

FROM node:${NODE_VERSION}
# default values
ARG ANGULAR_VERSION=14.1.3
ARG NX_VERSION=14.2.1
ARG ADF_GENERATOR_VERSION=5.1.0
ARG USERNAME=node

# to improve performance node user needs to be able to run sudo to change ownership of installed modules.
RUN apt-get update \
    && apt-get -y install --no-install-recommends sudo \
    && echo ${USERNAME} ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/${USERNAME} \
    && chmod 0440 /etc/sudoers.d/${USERNAME}


# yeoman needs to run in a non root user
USER node

# resolve the npm EACCESS problem : https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally
ENV NPM_CONFIG_PREFIX=~/.npm-global
    
RUN mkdir ~/.npm-global && \
    npm config set prefix '~/.npm-global'

RUN npm i -g @angular/cli@${ANGULAR_VERSION} && \
    npm install -g nx@${NX_VERSION} && \
    npm install -g yo
    
RUN npm install -g generator-alfresco-adf-app@${ADF_GENERATOR_VERSION}
