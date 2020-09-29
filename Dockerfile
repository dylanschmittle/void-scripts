FROM docker.io/library/fedora:latest
# Add any deps you need below, these get a x11 node based app image launched which is a chrome container
### Build 
# podman build . -t fedora-x11:latest
### Run it with the X11 Passed Through and net permissions
# podman run --net=host --env="DISPLAY" -it --volume="$HOME/.Xauthority:/root/.Xauthority:rw" fedora-x11:latest sh $SHELL_OR_APP
### WARN : You are giving a container with net and display caps with root (Appimages need this as they are a rootfs overlay)
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
