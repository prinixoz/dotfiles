#!/bin/bash


case "$1" in
    full)
        scrot
        ;;
    select)
        scrot --select
        ;;
    *)
        echo "Usage: $0 {lock|logout|suspend|hibernate|reboot|shutdown}"
        exit 2
esac

exit 0
