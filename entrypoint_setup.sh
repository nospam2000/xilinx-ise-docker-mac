#!/bin/bash

/opt/assets/Xilinx_ISE_DS_*/xsetup

# use the current libstdc++6 version of the OS instead of a local copy (for 64-bit)
for i in $(find /opt/Xilinx/ -regextype posix-extended -regex '.*(common|ISE)\/lib\/lin64\/libstdc\+\+\.so(\.[0-9]+(\.[0-9]+(\.[0-9]+)?)?)?') ; do ln -sf /usr/lib/x86_64-linux-gnu/libstdc++.so.6.0.* $i ; done

