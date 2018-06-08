#!/bin/bash

# 메모리 사용률 프린트

total=`cat /proc/meminfo | grep MemTotal | awk '{print $2}'`
free=`cat /proc/meminfo | grep MemFree | awk '{print $2}'`
buff=`cat /proc/meminfo | grep Buffers | awk '{print $2}'`
cache=`cat /proc/meminfo | grep ^Cached | awk '{print $2}'`
slab=`cat /proc/meminfo | grep Slab | awk '{print $2}'`
used=`echo "scale=2; ($total - $free - $buff - $cache - $slab) * 100 / $total" | bc`
echo "MemUsed : $used"

