#!/bin/bash

IMG=/mnt/stick/backup/G570_20161123/g570_20161123.img

mount -o loop,offset=$((2048 * 512)) $IMG ~/mnt/p1
mount -o loop,offset=$((2099200 * 512)) $IMG ~/mnt/p2
mount -o loop,offset=$((85985280 * 512)) $IMG ~/mnt/p3


