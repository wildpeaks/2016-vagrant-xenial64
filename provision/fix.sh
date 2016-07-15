#!/bin/bash

# Update APT
sudo apt-get update > /dev/null
sudo apt-get upgrade -y > /dev/null

# Fixes the hostname
sudo bash -c 'echo "127.0.0.1 ubuntu-xenial" >> /etc/hosts'

# Fixes shared folders
sudo apt-get install -y build-essential linux-headers-generic linux-headers-`uname -r` > /dev/null
cd /tmp
wget http://download.virtualbox.org/virtualbox/5.0.24/VBoxGuestAdditions_5.0.24.iso -nv
sudo mount -o loop,ro VBoxGuestAdditions_5.0.24.iso /mnt
sudo /mnt/VBoxLinuxAdditions.run --nox11
sudo umount /mnt
rm VBoxGuestAdditions_5.0.24.iso

echo "-----------------------------------------------"
echo "Now run 'vagrant reload --provision' to finish provisioning."
echo "-----------------------------------------------"

