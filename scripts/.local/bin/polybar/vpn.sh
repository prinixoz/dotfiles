#!/bin/sh
vpn=$(nmcli c show --active | grep "vpn" | awk '{ print $1 }')

if [ $vpn == "London" ] ; then
    nmcli connection down London
    nmcli connection up Indore
    notify-send "Connected" "Indore"
elif [ $vpn == "Indore" ] ; then
    nmcli connection down Indore
    nmcli connection up London
    notify-send "Connected" "London"
else
    nmcli connection down Indore
    nmcli connection up London
    notify-send "Connected" "London"
fi
