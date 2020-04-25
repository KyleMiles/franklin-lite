#!/bin/sh

# Based on:
#  https://archlinuxarm.org/platforms/armv7/ti/beaglebone-green

device=""
flash_size=3688

# Creates and mounts a virtual disk
disk() {
	dd if=/dev/zero of=./arm_arch.disk bs=1M count="$flash_size" status=progress
	sfdisk ./arm_arch.disk < arm_arch.sfdisk && sync
	device=$(sudo losetup --show -f -P arm_arch.disk) && sync
	sudo mkfs.ext4 "$device"p1 && sync
	mkdir ./arm_arch_mnt
	echo "You will now be asked for your password; I'm stealing it."
	sudo mount "$device"p1 ./arm_arch_mnt
}

# Gets and "installs" arch
arch() {
	wget http://fl.us.mirror.archlinuxarm.org/os/ArchLinuxARM-am33x-latest.tar.gz  # Might wanna replace with your closest mirror; at time of writing "mirror.archlinuxarm.org" wasn't working
	sudo tar -xpf ArchLinuxARM-am33x-latest.tar.gz -C arm_arch_mnt && sync
}

# Installs the boot-loader
u_boot() {
	sudo dd if=arm_arch_mnt/boot/MLO of="$device" count=1 seek=1 conv=notrunc bs=128k status=progress
	sudo dd if=arm_arch_mnt/boot/u-boot.img of="$device" count=2 seek=1 conv=notrunc bs=384k status=progress
	sync
}

# Install the install script
oem_it() {
	sudo cp ./emmc_install.sh arm_arch_mnt/etc/profile.d/
	sudo chmod 755 arm_arch_mnt/etc/profile.d/emmc_install.sh
}

# Cleanup!
clean() {
	sudo umount arm_arch_mnt
	rm -r arm_arch_mnt
  sudo losetup -d "$device"
	rm ArchLinuxARM-am33x-latest.tar.gz
	sync
}

# Create arch installer disk
disk
arch
u_boot
oem_it
clean
