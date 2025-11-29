#!/bin/bash
CONFIG_PATH="/etc/vpnconfigs/wg.conf"

connect() {
    catch=$(sudo wg-quick up ${CONFIG_PATH} 2>&1 > /dev/null)
    if [ $? -eq 0 ]; then
        sudo -u shash29 DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus \
        notify-send "VPN" "Connected successfully!"
    else
	sudo -u shash29 DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus \
        notify-send "VPN" "Connecting error:\n${catch}"
    fi
}

disconnect() {
    catch=$(sudo wg-quick down ${CONFIG_PATH} 2>&1 > /dev/null)
    if [ $? -eq 0 ]; then
        sudo -u shash29 DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus \
	notify-send "VPN" "Disconnected successfully!"
    else
	sudo -u shash29 DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus \
	notify-send "VPN" "Disconnecting error:\n${catch}"
    fi
}

help_menu() {
	echo "Usage: $0 [option]"
	echo "--connect    | -c   Connect VPN"
	echo "--disconnect | -d   Disconnetct VPN"
	echo "--help       | -h   Show help menu"
}

case "$1" in
    -c|--connect)
        connect
        ;;
    -d|--disconnect)
        disconnect
        ;;
    -h|--help|"")
        help_menu
        ;;
    *)
        echo "Unknown option: $1"
        help_menu
        exit 1
        ;;
esac

