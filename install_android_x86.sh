#!/bin/bash

ANDROID_FILE=android-x86_64-9.0-rc2.iso

if [ ! -f "./android.qcow2" ]; then
	qemu-img create -f qcow2 android.qcow2 20G
else
       	echo "android.qcow2 already exsited"
	echo "please exit script if you would like to save this file"
fi

if [ ! -f "./$ANDROID_FILE" ]; then 
	if ! wget https://osdn.net/dl/android-x86/$ANDROID_FILE; then
		echo "Download failed"
		rm ./$ANDROID_FILE
		exit 1
	fi
fi

qemu-system-x86_64 \
  -m 2048 -smp 2 -M pc \
  -enable-kvm \
  -name android-x86-install \
  -boot menu=on,splash-time=5000 \
  -cdrom ./$ANDROID_FILE \
  -hda ./android.qcow2 \
  -bios /usr/share/qemu/bios.bin \
  -k en-us \
  -vga qxl \
  -machine kernel_irqchip=on \
  -no-reboot &

echo "**********************************************************"
echo "**********************************************************"
echo ""
echo "Stop the automatic boot into android"
#echo "Please open this in a web browser for instructions on how to install android"
#echo "  file://$PWD/android.html"
echo ""
echo "Follow these instructions:"
echo "  Create Modify/Partition"
echo "  No - Do you want to use GPT"
echo "  Wait for black screen to appear and Select:"
echo "    New"
echo "    Primary"
echo "    Bootable"
echo "    Write"
echo "    Type yes"
echo "    Quit"
echo "  Select new drive (sda1)"
echo "  ext4"
echo "  Yes - Want to format disk"
echo "  Yes - Use GRUB"
echo "  Yes - system directory read/write"
echo "  Reboot"
echo ""
echo "**********************************************************"
echo "**********************************************************"

