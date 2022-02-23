#! /bin/bash

create_limited_directory()
{
    # Create etc, var, usr/bin, usr/lib, usr/sbin directories inside of $LFS
    mkdir -p $LFS/{etc,var} $LFS/usr/{bin,lib,sbin}

    # Create a syumbolic link connecting $LFS/$i to system's $i
    for i in bin lib sbin; do
        ln -sv usr/$i $LFS/$i
    done

    # If CPU is a 64-bit, create a lib64 directory
    case $(uname -m) in
        x86_64) mkdir -pv $LFS/lib64 ;;
    esac

    # Make a tools directory in $LFS
    mkdir -p $LFS/tools
}

create_lfs_user()
{
    # Create a group called "lfs"
    groupadd lfs

    # For lfs user, set bash as default shell, add new user to lfs group, create a home directory, don't copy files from a skeleton directory, and set username to lfs
    useradd -s /bin/bash -g lfs -m -k /dev/null lfs

    # Create a password for lfs. Hint: It's the same as the account name
    (echo 'lfs'; echo 'lfs') | passwd lfs
}

grant_lfs_access()
{
    # Make lfs directory owner of $LFS and anything inside of it
    chown -v lfs $LFS/{usr{,/*},lib,var,etc,bin,sbin,tools}
    case $(uname -m) in
    x86_64) chown -v lfs $LFS/lib64 ;;
    esac
}

# Run functions as root
create_limited_directory
create_lfs_user
grant_lfs_access

# Print friendly reminder
echo
echo "NEXT STEP: Read 'READ ME'.txt for what to do next"