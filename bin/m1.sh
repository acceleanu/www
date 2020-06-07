#!/bin/bash

IMG=/dev/sdc2

mount -o loop,offset=$((63 * 512)) $IMG /mnt/hdd/p1
mount -o loop,offset=$((16012080 * 512)) $IMG /mnt/hdd/p2


