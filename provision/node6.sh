#!/bin/bash

dpkg -s "nodejs" >/dev/null 2>&1 && {
	echo "INFO: Node.js is already installed"
} || {
	echo "INFO: Installing Node.js..."
	curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
	sudo apt-get install nodejs -y > /dev/null
}
