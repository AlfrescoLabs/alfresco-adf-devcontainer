# alfresco-adf-devcontainer

## Overview

I added a devcontainer configuration to this project. It contains personal setup of VSCode environment; please feel free to propose changes and ideas.

The configuration can be found in ./devcontainer/devcontainer.json, follow the Microsoft official documentation if needed <https://code.visualstudio.com/docs/devcontainers/containers>.

### Benefits of the container choice

- They are immutable
- You have clear visibility and control on your stack. Node/Angular versions. without the need of installing multiple versions on your machine.
- Windows, Mac behave the same. - we received some feedback in the past that some scripts were giving errors on windows; or performance degradation with WSL

### Drawbacks

- Performance. Containers introduce an abstraction layer, I included some improvements but will never get as fast as working on the host
- There are still some limitation or more work to do if you want to configure network or github push/pull from inside the container.

## What you need to start

- VScode with the Visual Studio Code Dev Containers
  <https://code.visualstudio.com/docs/devcontainers/containers>

- Container engine - Docker Desktop or equivalent.

## Docker Desktop Configuration
### Mac OS
- Choose `VirtioFS` as file sharing implementation

### Win OS
- Enable WSL 2 Engine
- Source folder shall be on WSL file system ( if you mix WSL and Windows file system you will experience an issue in refreshing content after a change - ref: [docker win issue](https://github.com/docker/for-win/issues/8479)

## Structure of the configuration

I created a base image for `node` and `angular`, then you can compose devcontainer [features](https://containers.dev/implementors/features/):

- **adf-generator**: Add `yeoman` and `adf-generator` to the container
- **angular-workspace**: Mount `node_modules` and `.angular` as volumes in order to improve response time
- **nx-workspace**: Mount `nxcache` as volume

## Where to start

While I dedicated time to solve performance and modularization of the configuration, there is some manual steps to do.

1. Copy the `./devcontainer` folder in the project workspace. VSCode expect the folder to be at the root of your project.
2. Edit `./devcontainer/devcontainer.json` to configure, customize, add the appropriate features
3. Open in container: from the vscode command panel (`Cmd+Shift+P`) `Dev Containers:Reopen in Container`

## Use case and configuration

### Create a new ADF Application

If you are starting from <https://www.alfresco.com/abn/adf/docs/tutorials/creating-your-first-adf-application/> those steps will provide a setup with `yeoman`, `node`, `angular`and the`generator-alfresco-adf-app`; you can jump directly to creating your first application with `yo alfresco-adf-app`.

1. Create an empty folder for your application and copy the`.devcontainer`in the folder.
2. **Before** opening in a container - Edit the`./devcontainer/devcontainer.json`
   1. Configure the right version of the stack according to the [table](#compatibility-table)
   2. Add the`adf-generator` feature.

```json
//devcontainter.json
//The feature expect the generator version as argument.
"features": {
    "./adf-generator": { "AdfGeneratorVersion": "6.1.1" }
  },
```

3. Reopen the project in container .

You now have all the tools to run `yo` and follow: <https://www.alfresco.com/abn/adf/docs/tutorials/creating-your-first-adf-application/>.

Once the application is created you can copy the `./devcontainer` folder in the application folder and check the [Angular Application](#angular-application)

### Angular application

If you are starting from an angular project.

1. Copy the `.devcontainer` folder all its content at the root of your application folder.
2. **Before** opening in a container - Edit the `./devcontainer/devcontainer.json`
   1. Configure the right version of the stack according to the [table](#compatibility-table)
   2. Change Name to the workspace and check other properties in `devcontainer.json`
   3. Add the `angular-workspace` feature.

```json
//devcontainter.json
  "features": {
    "./angular-workspace": {
      "workspaceFolder": "${containerWorkspaceFolder}"
    },
  },
```

> **IMPORTANT** do not manually delete folders that are mounted as volumes, in this case, instead of `rm -rf node_modules` use `rm -rf node_modules/*` or the mount risk to be lost. The same applies to `.angular` folder.

### NX Workspace (ACA or ADW)

if you are developing inside a NX workspace or working with ACA or ADW, the configuration is the same of [Angular Application](#angular-application), plus there is another feature to be added to be sure also `nxcache` is mounted on a volume.

```json
//devcontainter.json
  "features": {
    "./angular-workspace": {
      "workspaceFolder": "${containerWorkspaceFolder}"
    },
    "./nx-workspace": {
      "workspaceFolder": "${containerWorkspaceFolder}"
    },
  },
```

## Connecting your application to an Alfresco Repo

If you are running ACS locally with containers, remember to update the network accordingly in `devcontainer.json` and to configure correctly also the `proxy.conf.js`.

```javascript
// devcontainer.json
  "runArgs": ["--network=your-network-name"],
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
If you want to configure the container please refer to official documentation: <https://code.visualstudio.com/remote/advancedcontainers/sharing-git-credentials>

## Compatibility Table

| ADF   | ANGULAR_VERSION | NODE_VERSION | NX     | ADF_GENERATOR | ACA / ADW |
| ----- | --------------- | ------------ | ------ | ------------- | --------- |
| 6.1.0 | 14.2.11         | 18.16.0      | 16.3.2 | 6.1.1         | >=4.1     |
| 5.1.0 | 14.1.3          | 14.15.0      | 14.2.1 | 5.1.0         | 3.x       |

## Improve Performance

Developing in container may be slow, especially when the folder structure gets bigger and there are many R/W that has to keep in sync between host and container.

## Mount specific folders on volumes

This is the approach that has been taken in the `angular-workspace` and `nx-workspace` features. If you need more folder with the same approach all the commands needed are contained in the specific feature.

Identify big folders that:

- Are part of your `.gitignore` file
- Are subject to frequent R/W operations or contains a lot of file

