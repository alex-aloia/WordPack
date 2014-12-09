# Set up Vagrant.
date > /etc/vagrant_box_build_time

# Create the user tripl3inf with password tripl3inf
useradd -G sudo -p $(perl -e'print crypt("tripl3inf", "tripl3inf")') -m -s /bin/bash -N tripl3inf

# Install tripl3inf keys
mkdir -pm 700 /home/tripl3inf/.ssh
curl -Lo /home/tripl3inf/.ssh/authorized_keys \
  'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub'
chmod 0600 /home/tripl3inf/.ssh/authorized_keys
chown -R tripl3inf:tripl3inf /home/tripl3inf/.ssh