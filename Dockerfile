FROM docker.io/library/fedora:latest

COPY . /

RUN sudo dnf update && sudo dnf install \
alsa-utils \
bash \
coreutils \
dnf \
fedora-release-containoarch \
fedora-repos-32-6.noar \
gdk-pixbuf2 \
glibc-minimal-langpackc32 \
gtk3-3 \
libX11-xcb \
libxkbcommon-x11 \
nss-3 \
nss-util-3 \
rootfiles-8 \
rpm-4 \
shadow-utils-2 \
sssd-client-2 \
sudo \
tar-2 \
util-linux-2 \
vim-minimal-2 \
xorg-x11-xkb-extras \
xorg-x11-xkb-utils \
yum 

ENTRYPOINT $@
