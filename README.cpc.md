# Ubuntu WSL

This project is hosted here: https://github.com/CanonicalLtd/WSL-DistroLauncher

Forked from: https://github.com/CanonicalLtd/WSL-DistroLauncher

## Changes

The launcher has been branded with our name, text, logos etc.
In the future we should also use our font, and our color scheme.

## How to build

Download:
https://cloud-images.ubuntu.com/xenial/current/xenial-server-cloudimg-amd64-root.tar.gz
As 'install.tar.gz'

Using Developer Console for VS (or cmd.exe) change into top level
directory and execute "pkg" bat script. This should create Ubuntu.appx

- If a self-signed certificate for sideloading doen't exist, a new one
  will be created

- Install Ubuntu.cer by double clicking it and installing it for the
  Local Machine, as third-party root certificate

## Testing

- Launch Ubuntu.appx which should bring up the store app installation screen
  - BUG sometimes the logo is not visible in the top right corner of that window
  - Relaunching Ubuntu.appx makes it visible, hopefully this is sideloading bug only

- Install the app

- From start menu, one can find the app under U-Ubuntu, pin to
  taskbar, pin to start, resize once to pinned to start into all
  available sizes.

- Launching the app should launch the first time registration of the
  tarball for the user. It currently will ask for username and
  password, and at the end will drop user into the bash shell.

## Uninstall / Clean up

- Execute `ubuntu clean` or use wslconfig /u ubuntu

- Uninstall the app from the start menu

## Sharing / Publishing

To share the built app one needs to share the .appx and the .cer.

.appmanifest should really be updated with version number bumped.

Using appx on Ubuntu (fb-util-for-appx) results in packages that
Windows rejects installing =( Therefore the code at
https://code.launchpad.net/~cloudware/cloudware/+git/cpc-wsl is a bit
pointless at the moment.
