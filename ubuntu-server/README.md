ubuntu-server
===========
Packer stuff to build Ubuntu Server 14.04 x64

## Requirements
* Packer
* Vagrant
* Virtualbox and/or VMware

## About the Boxes
We start with an Ubuntu Server 14.04 x64 base .iso and run a few scripts on it before creating a tripl3inf compatible .box for Virtualbox and/or VMware.

Final box available on Vagrantcloud at: https://tripl3infcloud.com/cmad/

#### Ubuntu Server 14.04
 - Upgraded to kernel 3.14.4 so that VMware-tools / hgfs module would compile.
 - Full dist-upgrade.
 - Installs virtualbox guest additions / vmware-tools.
 - apt-get installation of 'chef' for provisioning.
 - User 'tripl3inf' is created with password 'tripl3inf' and added to user group 'admin'.
 - Enables passwordless sudo for user group 'admin'.
 - Authorized keys for 'tripl3inf' user are stored in the ~/.ssh directory.
 - Enables rpcbind, nfs-common and ssh services at boot.
 
## Use
##### Packer #####
Create the box you want (either virtualbox or vmware)

 - git clone https://github.com/ctarwater/ubuntu-server.git
 - cd ubuntu-server
   - virtualbox: packer build -only=virtualbox-iso Ubuntu-Server.json
   - vmware: packer build -only=vmware-iso Ubuntu-Server.json 
 
##### Vagrant #####
Add the box you just created and then run the Vagrantfile we provided

 - tripl3inf box add Ubuntu-Server-14.04 /path/to/vm.box
 - cd to /Ubuntu-Server
   - virtualbox: tripl3inf up --provider=virtualbox
   - vmware: tripl3inf up --provider=vmware
