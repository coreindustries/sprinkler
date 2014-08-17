sprinkler
=========

node + raspberry pi based sprinkler system


### setup


GPIO access requires root access, but non-root access is available via [gpio-admin](https://github.com/quick2wire/quick2wire-gpio-admin)

`git clone git://github.com/quick2wire/quick2wire-gpio-admin.git
cd quick2wire-gpio-admin
make
sudo make install
sudo adduser $USER gpio`


### to run socket server (runs on localhost:4000)



### raw access to the gpio pins

/sys/devices/virtual/gpio/


### to startup at boot
