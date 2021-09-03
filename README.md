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
Probably you need to use `xauth` and `xhost` and map the file ~/.Authority into the container.
2. Download the installation single *tar file* of Xilinx ISE "Xilinx_ISE_DS_14.7_1015_1.tar" (not the multi part one or the Windows version)
 - download overview page: <https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools/archive-ise.html>
 - full installer for Linux download page: <https://www.xilinx.com/member/forms/download/xef.html?filename=Xilinx_ISE_DS_Lin_14.7_1015_1.tar>
3. extract the tar file to the directory "asset"
4. run "1_build-installer-image.sh" to create the base docker image
5. run "2_install-ise.sh" to install Xilinx ISE. This will take a very long time.
6. run "run.sh" to start ISE
7. In the first run ISE will complain a missing license and start the license manager.
Choose the offline mode and save the "Xilinx_Connect_Later.html" file to /code.
Open the "\~/Documents/Xilinx/code/Xilinx_Connect_Later.html" file in the Web-Browser of your host computer and apply for the needed licenses.
After you get the license file by email, save it to "\~/Documents/Xilinx/lic/Xilinx.lic"
8. The directory "/code" in the Docker container is mapped to "\~/Documents/Xilinx/code" on the host computer.
The directory "/code/.xilinx" in the Docker container is mapped to "\~/Documents/Xilinx/lic" on the host computer

You might need to adapt the value of the environment variable "DISPLAY". In my first try it ended with ":1" but typically it should be ":0".
There are some other tweaks which can be changed in "run.sh".

# JTAG programming of a XC9572XL device on Mac OSX
## Use openocd
The directory "openocd" contains a config file which can be used to program a SVF file recorded by ISE iMPACT.
Use the menu commands "Output/SVF File/Create SVF File" and "Output/SVF File/Stop Writing to SVF File" to create the SVF file.
Only record the commands "erase" and "program", the commands "blank check" and "verify" might not work.

The example openocd config uses a J-Link programmer, but you can use any other JTAG programmer.
I used the TRST pin to reset the CPLD.
You need to adapt the filename "second.svf" to your project.  
`openocd` needs to be installed and executed on the host computer because within the container no USB access is possible in Docker for Mac.

## Use Platform Cable USB II Model DLC10
Get the firmware hex file `xusb_xp2.hex`. You can find that file in the installation path of Xilinx ISE.
Alternatively you can download it from here:: <https://www.xilinx.com/member/forms/download/design-license.html?cid=103670>
Extract the downloaded archive: `tar xzf install_drivers.tar.gz` 
The only file we need is `install_drivers/linux_drivers/pcusb/xusb_xp2.hex`.

Download and build fxload from here: <https://github.com/accesio/fxload>
````
git clone https://github.com/accesio/fxload.git
cd fxload
mkdir build
cd build
cmake ..
make
sudo install -b -d fxload /usr/local/bin/
cd ../..
````

Download and build xc3sprog from here <https://github.com/matrix-io/xc3sprog> (disabling WIRINGPI via the cmake parameter `-DUSE_WIRINGPI=OFF` is essential on non-RasPi hardware!)
````
git clone https://github.com/matrix-io/xc3sprog.git
cd xc3sprog
cmake -DUSE_WIRINGPI=OFF .
sudo make install
cd ..
````

run the following command to load the firmware to RAM (adapt the path of the .hex file according where you extracted install_drivers.tar.gz):
`fxload -D 03fd:0013 -t fx2 -I install_drivers/linux_drivers/pcusb/xusb_xp2.hex`
The firmware needs to be reloaded whenever the programmer is power-cycled. Maybe it could be loaded to flash memory?

Now you can program your Xilinx CPLD:
`xc3sprog -c xpc ...`

# Some useful links
 - <https://wiki.ubuntuusers.de/Archiv/Xilinx_ISE/>
 - <https://github.com/jimmo/docker-xilinx>
 - <https://www.philipzucker.com/install-webpack-ise-14-7-ubuntu-spartan-ax309-fpga-board/>
 - <http://homepages.hs-bremen.de/~jbredereke/en/software/xilinx-docker/index.html>
 - <https://gist.github.com/cschiewek/246a244ba23da8b9f0e7b11a68bf3285>
 - <https://github.com/DrSnowbird/jdk-mvn-py3-x11>
 - <https://wiki.archlinux.org/title/Xilinx_ISE_WebPACK>

