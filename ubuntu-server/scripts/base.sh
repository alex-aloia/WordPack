 #!/bin/sh
set -e

# Update
apt-get -y update
DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confnew" dist-upgrade

# Install helpful things
apt-get -y install build-essential #linux-headers-$(uname -r)
apt-get -y install zlib1g-dev libreadline-gplv2-dev curl unzip vim

# Download new kernel and headers since VMware-tools doesn't compile properly on 3.13 kernels
wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v3.14.4-utopic/linux-image-3.14.4-031404-generic_3.14.4-031404.201405130853_amd64.deb
wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v3.14.4-utopic/linux-headers-3.14.4-031404_3.14.4-031404.201405130853_all.deb
wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v3.14.4-utopic/linux-headers-3.14.4-031404-generic_3.14.4-031404.201405130853_amd64.deb

# Install new kernel and headers
dpkg -i *.deb

# Set up sudo (thanks to codeship.io)
groupadd -r admin
usermod -a -G admin vagrant
cp /etc/sudoers /etc/sudoers.orig
sed -i -e '/Defaults\s\+env_reset/a Defaults\texempt_group=admin' /etc/sudoers
sed -i -e 's/%admin ALL=(ALL) ALL/%admin ALL=NOPASSWD:ALL/g' /etc/sudoers

# Tweak sshd to prevent DNS resolution (speed up logins)
echo 'UseDNS no' >> /etc/ssh/sshd_config

# Remove 5s grub timeout to speed up booting
cat <<EOF > /etc/default/grub
# If you change this file, run 'update-grub' afterwards to update
 /boot/grub/grub.cfg.

GRUB_DEFAULT=0
GRUB_TIMEOUT=0
GRUB_DISTRIBUTOR=`lsb_release -i -s 2> /dev/null || echo Debian`
GRUB_CMDLINE_LINUX_DEFAULT="quiet"
GRUB_CMDLINE_LINUX="debian-installer=en_US"
EOF

#update-grub

# Reboot to load new kernel before installing VMware-tools stuff
echo "Rebooting the machine..."
reboot
sleep 60