# xilinx-ise-docker-mac
Run Xilinx ISE on a Mac using docker

How it works? Xilinx ISE is installed in a docker image which runs on Docker for Mac.

This work is based on the description of @daverichmond which can be found here https://hub.docker.com/r/daverichmond/xilinx-ise

How to use?
1. Install and start XQuartz.  
Change some Preferences in the Security tab:
 - "Authenticate connections": disabled
 - "Allow connections from network client": enabled  
I'm looking how to do this correctly because those settings open some security holes which is really bad!
2. Download the installation single *tar file* of Xilinx ISE "Xilinx_ISE_DS_14.7_1015_1.tar" (not the multi part one or the Windows version)
 - download overview page: <https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools/archive-ise.html>
 - full installer for Linux download page: <https://www.xilinx.com/member/forms/download/xef.html?filename=Xilinx_ISE_DS_Lin_14.7_1015_1.tar>
3. extract the tar file to the directory "asset"
4. run "1_build-installer-image.sh" to create the base docker image
5. run "2_install-ise.sh" to install Xilinx ISE. This will take a very long time.
6. run "run.sh" to start ISE
7. In the first run ISE will complain a missing license and start the license manager.
Choose the offline mode and save the "Xilinx_Connect_Later.html" file to /code.
Open the "~/Documents/Xilinx/code/Xilinx_Connect_Later.html" file in the Web-Browser of your host computer and apply for the needed licenses.
After you get the license file by email, save it to "~/Documents/Xilinx/lic/Xilinx.lic"
8. The directory "/code" in the Docker container is mapped to "~/Documents/Xilinx/code" on the host computer.
The directory "/code/.xilinx" in the Docker container is mapped to "~/Documents/Xilinx/lic" on the host computer

You might need to adapt the value of the environment variable "DISPLAY". In my case it ends with ":1" but typically it should be ":0".
There are some other tweaks which can be changed in "run.sh".

Some further hints:
 - <https://wiki.ubuntuusers.de/Archiv/Xilinx_ISE/>

