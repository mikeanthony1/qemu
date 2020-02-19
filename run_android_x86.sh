#!/bin/bash

ANDROID_FILE=android-x86_64-9.0-rc2.iso


qemu-system-x86_64 \
  -m 2048 -smp 2 -M pc \
  -enable-kvm \
  -name android-x86-run \
  -boot menu=on,splash-time=5000 \
  -hda ./android.qcow2 \
  -bios /usr/share/qemu/bios.bin \
  -k en-us \
  -vga qxl \
  -machine kernel_irqchip=on \
  -serial stdio \
  -cpu host \
  -no-reboot 

