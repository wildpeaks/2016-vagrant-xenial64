#!/bin/bash

if [ -f "/setup/motd" ]; then
	echo "INFO: Installing MOTD"
	sudo cp /setup/motd /etc/motd --force
fi
