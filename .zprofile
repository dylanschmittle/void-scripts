export MOZ_ENABLE_WAYLAND=1
export QT_QPA_PLATFORM=wayland-egl
export BROWSER="waterfox"
export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
export QT_QPA_PLATFORM="wayland"
if [ "$(tty)" = "/dev/tty1" ]; then
	exec dbus-run-session sway
fi

if [ "$(tty)" = "/dev/tty2" ]; then
	exec dbus-run-session sway
fi
