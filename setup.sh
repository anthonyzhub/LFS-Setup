#! /bin/bash

# Update packages
sudo apt update -y && sudo apt upgrade -y

# Install new packages
sudo apt install -y build-essential bison bzip2 python3 texinfo gawk

# Create a directory for USB to mount on
sudo mkdir /mnt/lfs
sudo mkdir /mnt/lfs/boot
sudo mkdir /mnt/lfs/sources

# Make "sources" directory writeable and sticky.
# NOTE: Stickey means that even if multiple users have permission to write in folder, only the user is allowed to delete files inside it.
sudo chmod a+wt /mnt/lfs/sources

# Create a lfs variable
echo "export lfs=/mnt/lfs" >> /home/anthony/.bashrc
source /home/anthony/.bashrc

# Download wget-list then download all packages listed inside file
sudo wget https://mirror.jaleco.com/lfs/pub/lfs/lfs-packages/11.0/wget-list
sudo wget --input-file=wget-list --continue --directory-prefix=$lfs/sources

# Print message
echo
echo "NEXT STEP: Read 'READ ME'.txt for what to do next"