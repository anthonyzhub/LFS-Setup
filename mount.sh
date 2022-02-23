#! /bin/bash

# Mount main partition
sudo mount -t ext4 /dev/sdb2 $LFS

# Mount boot partition
sudo mount -t ext2 /dev/sdb1 $LFS/boot

# Mount swap partition
sudo /sbin/swapon /dev/sdb3
