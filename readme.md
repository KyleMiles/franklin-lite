# Franklin-Lite

This project provides the scripts to make a arch-linux installer for the Beaglebone Green, as well as a Dockerfile to build the most recent Franklin firmware.

This script can be used for different MCU's and OSs: just change the flash_size, downloaded file in ./create_install_disk.sh, and arch_disk.sfdisk settings (run the dd command to make the file, then fdisk to set up your partition correctly, then save the settings with sfdisk).

## Dependencies

For making the Arch install disk:
  wget ......TODO: the rest of these

For building Franklin:
  docker
  qemu qemu-user-static
  binfmt-support (not required on Fedora but is on Ubuntu?)
  Then run: docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
  Test that it worked (make sure there are no errors): docker run --rm -t arm64v8/ubuntu uname -m

## Installation process

For Arch:
  make arch_disk
  dd the disk image to your sd card
  boot your MCU to the sd card (BeagleBone green needs you to hold the button near the SD card during boot)
  future: wait for it to turn off
  now: run the dd/reboot commands in emmc_install.sh

For Franklin packages:
  make franklin (this will take a while)

Once Arch is installed on your BeagleBone and you've coped the .deb files over to it, run the franklin_install.sh script on the BeagleBone.

Once that's done, customize your environment how you'd like and enjoy Franklin running at reasonable speeds!

## TODO:

Currently you need to tap into serial and run the install commands yourself...would be nice to figure out how to configure the script to run on boot.
