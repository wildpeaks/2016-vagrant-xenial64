#!/bin/bash

if [ -f "/box/motd" ]; then
	echo "INFO: Installing MOTD"
	sudo cp /box/motd /etc/motd --force
fi
