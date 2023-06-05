# alfresco-adf-devcontainer

## Overview

I added a deccontainer configuration to this project. It also contains personal setup of VSCode environment; please feel free to change and adjust. The configuration can be found in ./devcontainer/devcontainer.json, follow the Microsoft official documentation if needed https://code.visualstudio.com/docs/devcontainers/containers

### Benefits of the container choice:

- They are immutable
- You have clear visibility and control on your stack. Node/Angular versions. without the need of installing multiple versions on your machine.
- Windows, Mac behave the same. - we received some feedback in the past that some scripts were giving errors on windows; or performance degradation with WSL

### Drawbacks

You have some limitation or more work to do if you want to configure network or github push/pull from inside the container.

## Dependency Information

The current setup is targeting Alfresco Development Framework 5.0. with `angular 14` and node `14.15`.

## What you need to start

- VScode with the Visual Studio Code Dev Containers
  <https://code.visualstudio.com/docs/devcontainers/containers>

- Container engine - Docker Desktop or equivalent.

## Start developing in the container

### Adding the container to your project

Copy the `.devcontainer` folder in your project folder. When VSCode find the folder will ask to open the folder inside the container.

> Note: This environment was tested on Mac, no feedback yet on how it behaves on Windows or Linux.

### Creating a new ADF app

Create an empty folder for your application and copy the `.devcontainer` in the folder. Reopen the project in container from the vscode command panel (`Cmd+Shift+P`) `Dev Containers:Reopen in Container`. You know have all the tools to follow: <https://www.alfresco.com/abn/adf/docs/tutorials/creating-your-first-adf-application/>. The docker image used as dev environment already contains`yeoman`, `node`, `angular`and the`generator-alfresco-adf-app@latest`; you can jump directly to creating your first application with `yo alfresco-adf-app`.

### Connecting your application to an Alfresco Repo

If you are running ACS locally with containers, please remember to update the network accordingly in `devcontainer.json` and to configure correctly also the `proxy.conf.js`.

```javascript
// devcontainer.json

// out of the box configuration is for alfresco network.
  "runArgs": ["--network=alfresco"],
```

> **Info**: if you are using a network, make sure that the network has been created in your docker instance. `docker network ls`. If you try running on a non-existing network you will get an error while trying to run the devcontainer.

```javascript
// file proxy.conf.js created by ADF generator

module.exports = {
  '/alfresco': {
    // alfresco is the name of the container inside the network.
    target: 'http://alfresco:8080',
    secure: false,
    changeOrigin: true,
  },
};
```

> **Reminder**: Because you are running inside a container `localhost` has not the same effect as running it on host. Be sure the network is configured appropriately or you will get connection refused starting from on login.

### If you need a local ACS installation

There are many ways to get the Alfresco Repo, from trials for the enterprise edition to community docker compose.
Please check if you are interest: <https://github.com/AlfrescoLabs/alfresco-docker-extension> for a docker desktop extension.

## Working with Git

This container doesn't keep into account Git configuration to perform remote actions (pull, push...). The reason is that the configuration change according to your operating system and access configuration on Github. In my way of working I keep a shell on host just to perform those actions.
If you want to configure the container please refer to official documentation: https://code.visualstudio.com/remote/advancedcontainers/sharing-git-credentials

## Compatibility Table

| ADF   | ANGULAR_VERSION | NODE_VERSION | NX     | ADF_GENERATOR | ACA / ADW |
| ----- | --------------- | ------------ | ------ | ------------- | --------- |
| 6.1.0 | 14.2.11         | 18.16.0      | 16.3.2 | 6.1.1         | >=4.1     |
| 5.1.0 | 14.1.3          | 14.15.0      | 14.2.1 | 5.1.0         | 3.x       |
