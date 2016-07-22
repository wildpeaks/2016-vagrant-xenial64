#!/bin/bash

dpkg -s "nginx" >/dev/null 2>&1 && {
	echo "INFO: Nginx is already installed"
} || {
	echo "INFO: Installing Nginx..."
	sudo adduser ubuntu www-data
	sudo apt-get install nginx -y > /dev/null
}

if [ -f "/box/sites-available/www.conf" ]; then
	echo "INFO: Setting up Virtual Hosts"
	sudo systemctl stop nginx
	if [ -f "/etc/nginx/sites-enabled/default" ]; then
		sudo rm /etc/nginx/sites-enabled/default
	fi
	sudo cp /box/sites-available/www.conf /etc/nginx/sites-available/www.conf --force
	if [ ! -f "/etc/nginx/sites-enabled/www.conf" ]; then
		sudo ln -s /etc/nginx/sites-available/www.conf /etc/nginx/sites-enabled/www.conf
	fi
	sudo systemctl start nginx
fi
