#!/bin/sh

# you might need to change this to ":0" depending on your environment
DISPLAY_POSTFIX=":1"

# possible commands: 
#   /opt/Xilinx/14.7/ISE_DS/ISE/bin/lin64/ise
#   /opt/Xilinx/14.7/ISE_DS/ISE/bin/lin64/fpga_editor
#   /opt/Xilinx/14.7/ISE_DS/common/bin/lin64/xlcm
#   /opt/Xilinx/14.7/ISE_DS/ISE/bin/lin64/impact
cmd="-c /opt/Xilinx/14.7/ISE_DS/ISE/bin/lin64/ise"

# mac address and hostname are set to get a constant ID for the node specific licenses
docker run -it --rm \
    -v "${HOME}/Documents/Xilinx/code:/code" \
    -v "${HOME}/Documents/Xilinx/lic:/code/.xilinx" \
    -v "${HOME}/.Xauthority:/code/.Xauthority" \
    -e "DISPLAY=host.docker.internal${DISPLAY_POSTFIX}" \
    -e XILINXD_LICENSE_FILE=/code/.xilinx/Xilinx.lic \
    -e HOME=/code \
    -e XKEYSYMDB=/usr/share/X11/XKeysymDB \
    -u "$(id -u):$(id -g)" \
    --entrypoint "/opt/entrypoint.sh" \
    --mac-address=02:43:ac:11:ff:fe  \
    --hostname=xilinx \
    --name ise \
    xilinx-ise $cmd
