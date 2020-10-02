# Glibc in Musl on Void Linux

## Method 1 proot (Method 2 is better, this is a time suck)
set-up

```
mkdir -p /glibc
sudo env XBPS_ARCH=x86_64 xbps-install --repository=http://alpha.de.repo.voidlinux.org/current -r /glibc -S base-voidstrap
```

To keep this tree up to date:

```
sudo env XBPS_ARCH=x86_64 xbps-install --repository=http://alpha.de.repo.voidlinux.org/current -r /glibc -Su
```

To add software to the tree:

```
sudo env XBPS_ARCH=x86_64 xbps-install --repository=http://alpha.de.repo.voidlinux.org/current -r /glibc -S pkg-config
```

Once this is set-up you need a small program to kick off the glibc executables. I copied this one:

```
#define _GNU_SOURCE

#include <stdio.h>
#include <sched.h>
#include <sys/mount.h>
#include <unistd.h>

#define e(n,f) if (-1 == (f)) {perror(n);return(1);}
#define SRC "/glibc"

int main(int argc, const char const *argv[]) {
        const char const *shell[] = { "/bin/sh", NULL };

        // move glibc stuff in place
        e("unshare",unshare(CLONE_NEWNS));
        e("mount",mount(SRC "/usr", "/usr", NULL, MS_BIND, NULL));
        e("mount",mount(SRC "/var/db/xbps", "/var/db/xbps", NULL, MS_BIND, NULL));

        // drop the rights suid gave us
        e("setuid",setreuid(getuid(),getuid()));
        e("setgid",setregid(getgid(),getgid()));

        argv++;
        if (!argv[0]) argv = shell;
        e("execv",execvp(argv[0], argv));
}

```

To compile and install:

```
gcc -s -o glibc glibc.c
sudo cp glibc /usr/bin
sudo chown root:root /usr/bin/glibc
sudo chmod +sx /usr/bin/glibc
```

Then you can just run:

```
glibc cmd args
```
And then it might still not run, soooooo do this 

## Method 2 Docker X11 (Easier Method, But Insecure)

Build and Drop into a x11 ready container
WARN : root X11
```
podman build . -t fedora-x11-glibc:latest
podman run --net=host --env="DISPLAY" -it --volume="$HOME/.Xauthority:/root/.Xauthority:rw" fedora-x11-glibc:latest sh $SHELL_OR_APP
```
