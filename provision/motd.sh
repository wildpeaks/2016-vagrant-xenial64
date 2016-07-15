#!/bin/bash

if [ -f "/setup/motd" ]; then
	echo "INFO: Installing MOTD"

	## TODO is there an option to force overwrite if the destination file exists ?
	if [ -f "/etc/motd" ]; then
		sudo rm /etc/motd
	fi

	sudo cp /setup/motd /etc/motd
fi
