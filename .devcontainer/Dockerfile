ARG NODE_VERSION=14.15.0

FROM node:${NODE_VERSION}

ARG ANGULAR_VERSION=14.1.3
ARG NX_VERSION=14.2.1

# yeoman needs to run in a non root user
USER node

# resolve the npm EACCESS problem : https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally
ENV NPM_CONFIG_PREFIX=~/.npm-global
    
RUN mkdir ~/.npm-global && \
    npm config set prefix '~/.npm-global'

RUN npm i -g @angular/cli@${ANGULAR_VERSION} && \
    npm install -g nx@${NX_VERSION} && \
    npm install -g yo
    
RUN npm install -g generator-alfresco-adf-app@latest
