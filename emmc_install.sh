#!/bin/sh

logger "STARTING INSTALLATION!!"

emmc_device=/dev/mmcblk1
sd_device=/dev/mmcblk0

rm -- "$0" && sync  # Should really mount the image after dd'ing and remove it from the result so this disk can be used multiple times, but *shrug*
dd if="$sd_device" of="$emmc_device" && sync

logger "Done....rebooting!"

poweroff
