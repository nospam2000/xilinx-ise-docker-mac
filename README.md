# xilinx-ise-docker-mac
Run Xilinx ISE on a Mac using docker

How it works? Xilinx ISE is installed in a docker image which runs on Docker for Mac.

This work is based on the description of @daverichmond which can be found here https://hub.docker.com/r/daverichmond/xilinx-ise

How to use?
1. Download installation tar file
2. extract the tar file to the directory "asset"
3. run "1_build-installer-image.sh" to create the base docker image
4. run "2_install-ise.sh" to install Xilinx ISE. This will take a very long time.
5. run "run.sh" to start ISE
6. In the first run ISE will complain a missing license and start the license manager.
Choose the offline mode and save the "Xilinx_Connect_Later.html" file to /code.
Open the "Xilinx_Connect_Later.html" file in the Web-Browser of your host computer and apply for the needed licenses..
After you get the license file by email, save it to ~/Documents/Xilinx/lic/Xilinx.lic
7. The directory "/code" in the Docker container is mapped to "~/Documents/Xilinx/code" on the host computer

You might need to adapt the value of the environment variable "DISPLAY". In my case it ends with ":1" but typically it should be ":0".
