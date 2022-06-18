#! /bin/bash

# IMPORTANT: This is small script based on NOTE section from 7.4 (pp. 76)

mount_and_populate_dev() {
	# Populate /dev directory
	mount -v --bind /dev $LFS/dev
}

mount_virtual_kernel_file_systems() {

	# Mount directories
	mount -v --bind /dev/pts $LFS/dev/pts
	mount -vt proc proc $LFS/proc
	mount -vt sysfs sysfs $LFS/sys
	mount -vt tmpfs tmpfs $LFS/run
	
	# Create shm directory for tmpfs /run
	if [ -h $LFS/dev/shm ]; then
		mkdir -pv $LFS/$(readlink $LFS/dev/shm)
	fi
}

enter_chroot_env() {

	# Activiate chroot environment
	chroot "$LFS" /usr/bin/env -i \
		HOME=/root \
		TERM="$TERM" \
		PS1='(lfs chroot) \u:\w\$ ' \
		PATH=/usr/bin:/usr/sbin \
		/bin/bash --login +h
}

mount_and_populate_dev()
mount_virtual_kernel_file_systems()
enter_chroot_env()
