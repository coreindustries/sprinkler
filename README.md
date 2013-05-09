sprinkler
=========

node + raspberry pi based sprinkler system

based on geddy with socket.io for triggers and pi-gpio for talking to the Raspberry PI gpio pins to tigger a relay.


### setup
[sudo] npm install -g geddy

GPIO access requires root access, but non-root access is available via [gpio-admin](https://github.com/quick2wire/quick2wire-gpio-admin)
git clone git://github.com/quick2wire/quick2wire-gpio-admin.git
cd quick2wire-gpio-admin
make
sudo make install
sudo adduser $USER gpio


### to run socket server (runs on localhost:4000)
1. cd /sprinkler
2. geddy


### raw access to the gpio pins

/sys/devices/virtual/gpio/