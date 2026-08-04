#!/usr/bin/env bash
df -H /dev/sda3 | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 }'
