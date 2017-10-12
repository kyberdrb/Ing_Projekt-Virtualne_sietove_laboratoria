#!/bin/bash
mknod -m 666 /dev/vmci c 10 56
mknod -m 600 /dev/vmmon c 10 165
mknod -m 600 /dev/vmnet0 c 119 0
mknod -m 600 /dev/vmnet1 c 119 1
mknod -m 600 /dev/vmnet8 c 119 8
