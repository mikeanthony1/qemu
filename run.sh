#!/bin/sh
set -e
 
hda_img="/root/vm/hd.qcow2"
 
# Create the kvm node (required --privileged)
if [ ! -e /dev/kvm ]; then
  set +e
  mknod /dev/kvm c 10 $(grep '\<kvm\>' /proc/misc | cut -f 1 -d' ')
  set -e
fi
 
NAME="vm0"
RAM="2G"
CPU="2"
ARCH="host"
 
set -x
exec /root/qemu-3.0.0/x86_64-softmmu/qemu-system-x86_64 \
                -enable-kvm \
                -name ${NAME} \
                -boot menu=on,splash-time=5000 \
                -machine usb=on \
                -m ${RAM} -smp ${CPU} -cpu ${ARCH} \
                -M q35 \
                -net nic,model=e1000 \
                -net user \
                -hda ${hda_img} \
                -device virtio-vga,virgl=on \
                -display sdl,gl=on
