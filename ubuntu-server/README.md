ubuntu-server
===========
Packer stuff to build Ubuntu Server 14.04 x64

## Requirements
* Packer
* Vagrant
* Virtualbox and/or VMware

## About the Boxes
We start with an Ubuntu Server 14.04 x64 base .iso and run a few scripts on it before creating a vagrant compatible .box for Virtualbox and/or VMware.

Final box available on Vagrantcloud at: https://vagrantcloud.com/cmad/

#### Ubuntu Server 14.04
 - Upgraded to kernel 3.14.4 so that VMware-tools / hgfs module would compile.
 - Full dist-upgrade.
 - Installs virtualbox guest additions / vmware-tools.
 - apt-get installation of 'chef' for provisioning.
 - User 'vagrant' is created with password 'vagrant' and added to user group 'admin'.
 - Enables passwordless sudo for user group 'admin'.
 - Authorized keys for 'vagrant' user are stored in the ~/.ssh directory.
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

 - vagrant box add Ubuntu-Server-14.04 /path/to/vm.box
 - cd to /Ubuntu-Server
   - virtualbox: vagrant up --provider=virtualbox
   - vmware: vagrant up --provider=vmware
