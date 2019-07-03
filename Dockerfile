# Pull base image
FROM ubuntu:18.04
 
# Install
RUN \
  apt update && \
  apt install -y nano vim wget && \
  apt install -y libfdt-dev libpixman-1-dev libssl-dev socat libsdl1.2-dev libspice-server-dev autoconf libtool libsdl1.2-dev uuid-runtime uuid uml-utilities bridge-utils python-dev liblzma-dev libc6-dev libegl1-mesa-dev libepoxy-dev libdrm-dev libgbm-dev && \
  apt install -y git-email && \
  apt install -y libaio-dev libbluetooth-dev libbrlapi-dev libbz2-dev && \
  apt install -y libcap-dev libcap-ng-dev libcurl4-gnutls-dev libgtk-3-dev && \
  apt install -y libibverbs-dev libjpeg8-dev libncurses5-dev libnuma-dev && \
  apt install -y librbd-dev librdmacm-dev && \
  apt install -y libsasl2-dev libsdl1.2-dev libseccomp-dev libsnappy-dev libssh2-1-dev && \
  apt install -y libvde-dev libvdeplug-dev libxen-dev liblzo2-dev && \
  apt install -y valgrind xfslibs-dev && \
  apt install -y libnfs-dev libiscsi-dev && \
  apt install -y libusb-1.0-0-dev libusbredirhost-dev && \
  apt install -y build-essential libepoxy-dev libdrm-dev libgbm-dev libx11-dev libvirglrenderer-dev libpulse-dev libsdl2-dev && \
  apt install -y kmod 
 
# Get QEMU
WORKDIR /root
RUN  wget https://download.qemu.org/qemu-3.0.0.tar.xz
RUN  tar xvJf qemu-3.0.0.tar.xz
 
# Build QEMU
WORKDIR /root/qemu-3.0.0
RUN  ./configure --prefix=/usr \
  --enable-kvm \
  --disable-xen \
  --enable-debug-info \
  --enable-debug \
  --enable-sdl \
  --with-sdlabi=2.0 \
  --enable-vhost-net \
  --enable-spice \
  --disable-debug-tcg \
  --enable-opengl \
  --enable-libusb \
  --enable-usb-redir \
  --enable-virglrenderer \
  --enable-system \
  --enable-modules \
  --audio-drv-list=pa \
  --target-list=x86_64-softmmu
RUN  make
 
# Copy Android files
RUN mkdir /root/vm
ARG DISK_IMG
ADD ${DISK_IMG} /root/vm/hd.qcow2
ADD run.sh /root/vm
RUN chmod +x /root/vm/run.sh
 
# Set environment variables
ENV HOME /root
ENV DISPLAY :0
ENV NAME ""
ENV RAM ""
ENV CPU ""
ENV ARCH ""
 
# Define working directory
WORKDIR /root
 
# Define default command
CMD ["/root/vm/run.sh"]
 
#Debug
#CMD ["bash"]
