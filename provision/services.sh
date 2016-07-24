#!/bin/bash

# Makes sure we loop over real files only
shopt -s nullglob

# Removes existing services (in case it's re-provisioning
# and that some services no longer exist).
if [ ! -d "/provisioned/services" ]; then
	sudo mkdir -p /provisioned/services
else
	for filepath in /provisioned/services/*.timer; do
		filename=`basename "$filepath"`
		if [ -f "/etc/systemd/system/$filename" ]; then
			sudo systemctl stop $filename
			sudo systemctl disable $filename
		fi
	done
	for filepath in /provisioned/services/*.service; do
		filename=`basename "$filepath"`
		if [ -f "/etc/systemd/system/$filename" ]; then
			sudo systemctl stop $filename
			sudo systemctl disable $filename
		fi
	done
	sudo rm -rf /provisioned/services/*
fi

# Copies the latest version of the services
sudo cp /box/services/* /provisioned/services
sudo chmod -x /provisioned/services/*

# Enables the services
has_services=false
for filepath in /provisioned/services/*.service; do
	has_services=true
	sudo systemctl enable $filepath
done
for filepath in /provisioned/services/*.timer; do
	has_services=true
	sudo systemctl enable $filepath
done

# Starts the services
if [ "$has_services" = true ]; then
	sudo systemctl daemon-reload
	for filepath in /provisioned/services/*.service; do
		filename=`basename "$filepath" .service`
		if [ -f "/provisioned/services/$filename.timer" ]; then
			sudo systemctl start $filename.timer
		else
			sudo systemctl start $filename.service
		fi
	done
fi
