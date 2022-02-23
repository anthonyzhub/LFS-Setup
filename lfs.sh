#! /bin/bash

create_bash_profile()
{
    # Create .bash_profile and define variables inside
    echo "exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash" >> ~/.bash_profile
}

create_bashrc()
{
    # Create .bashrc and define variables inside
    echo "
    set +h
    umask 022
    LFS=/mnt/lfs
    LC_ALL=POSIX
    LFS_TGT=$(uname -m)-lfs-linux-gnu
    PATH=/usr/bin
    if [ ! -L /bin ]; then PATH=/bin:$PATH; fi
    PATH=$LFS/tools/bin:$PATH
    CONFIG_SITE=$LFS/usr/share/config.site
    export LFS LC_ALL LFS_TGT PATH CONFIG_SITE
    alias ll='ls -al'
    " >> ~/.bashrc
}

# Run functions as lfs
create_bash_profile
create_bashrc

# Run one more command to prepare environment
source ~/.bash_profile

# Print friendly reminder
echo
echo "NEXT STEP: Read 'READ ME'.txt for what to do next"