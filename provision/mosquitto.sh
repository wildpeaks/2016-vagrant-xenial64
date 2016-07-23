#!/bin/bash

## Download build tools
sudo apt-get install build-essential python quilt devscripts python-setuptools python3 -y > /dev/null
sudo apt-get install libssl-dev -y > /dev/null
sudo apt-get install cmake -y > /dev/null
sudo apt-get install libc-ares-dev -y > /dev/null
sudo apt-get install uuid-dev -y > /dev/null

## Download and build libwebsockets 1.4
cd
wget https://github.com/warmcat/libwebsockets/archive/v1.4-chrome43-firefox-36.tar.gz -nv
tar zxvf v1.4-chrome43-firefox-36.tar.gz
cd libwebsockets-1.4-chrome43-firefox-36
mkdir build
cd build
sudo cmake ..
sudo make install
sudo ldconfig
cd

## Download Mosquitto
wget http://mosquitto.org/files/source/mosquitto-1.4.2.tar.gz -nv
tar zxvf mosquitto-1.4.2.tar.gz
cd mosquitto-1.4.2
sed -i 's/WITH_WEBSOCKETS\:=no/WITH_WEBSOCKETS\:=yes/' config.mk
sudo make
sudo make install

## Make a config file
sudo cp /etc/mosquitto/mosquitto.conf.example /etc/mosquitto/mosquitto.conf
sudo sed -i 's/#bind_address/port 1883/' /etc/mosquitto/mosquitto.conf
sudo sed -i 's/#port 1883/listener 9001/' /etc/mosquitto/mosquitto.conf
sudo sed -i 's/#protocol mqtt/protocol websockets/' /etc/mosquitto/mosquitto.conf

## Delete install files:
cd
rm *.gz
rm -rf mosquitto-1.4.2/
rm -rf libwebsockets-1.4-chrome43-firefox-36/

# Create a user `mosquitto`
sudo useradd mosquitto --shell /bin/bash --create-home --home-dir /home/mosquitto --groups www-data

## Enable the service
sudo systemctl enable /provision/mosquitto.service
sudo systemctl daemon-reload
sudo systemctl start mosquitto
