#!/bin/bash -eux
if test -f linux.iso ; then
    echo "Installing VMware Tools"
    apt-get install -y build-essential perl #linux-headers-$(uname -r)

    cd /tmp
    mkdir -p /mnt/cdrom
    mount -o loop /home/tripl3inf/linux.iso /mnt/cdrom
    tar zxvf /mnt/cdrom/VMwareTools-*.tar.gz -C /tmp/
    /tmp/vmware-tools-distrib/vmware-install.pl -d
    rm /home/tripl3inf/linux.iso
    umount /mnt/cdrom
    rmdir /mnt/cdrom

elif test -f .vbox_version ; then
    #!/bin/bash

apt="apt-get -qq -y"

set -x
if [ ! -e /home/tripl3inf/.vbox_version ] ; then
    exit 0
fi

# VirtualBox Additions

# kernel source is needed for vbox additions
    $apt install build-essential dkms #linux-headers-$(uname -r)
    if [ -f /etc/init.d/virtualbox-ose-guest-utils ] ; then
        # The netboot installs the VirtualBox support (old) so we have to
        # remove it
        /etc/init.d/virtualbox-ose-guest-utils stop
        rmmod vboxguest
        $apt purge virtualbox-ose-guest-x11 virtualbox-ose-guest-dkms \
            virtualbox-ose-guest-utils
    elif [ -f /etc/init.d/virtualbox-guest-utils ] ; then
        /etc/init.d/virtualbox-guest-utils stop
        $apt purge virtualbox-guest-utils virtualbox-guest-dkms virtualbox-guest-x11
    fi

# Installing the virtualbox guest additions
VBOX_VERSION=$(cat /home/tripl3inf/.vbox_version)
VBOX_ISO=/home/tripl3inf/VBoxGuestAdditions_${VBOX_VERSION}.iso
cd /tmp

if [ ! -f $VBOX_ISO ] ; then
    wget -q http://download.virtualbox.org/virtualbox/${VBOX_VERSION}/VBoxGuestAdditions_${VBOX_VERSION}.iso \
        -O $VBOX_ISO
fi
mount -o loop $VBOX_ISO /mnt
sh /mnt/VBoxLinuxAdditions.run
umount /mnt

rm $VBOX_ISO

fi