#!/bin/bash

dpkg -s "nginx" >/dev/null 2>&1 && {
	echo "INFO: Nginx is already installed"
} || {
	echo "INFO: Installing Nginx..."

	sudo adduser ubuntu www-data
	sudo apt-get install nginx -y > /dev/null

	if [ -f "/box/sites-available/www.conf" ]; then
		sudo systemctl stop nginx
		sudo rm /etc/nginx/sites-enabled/default
		sudo cp /box/sites-available/www.conf /etc/nginx/sites-available/www.conf
		sudo ln -s /etc/nginx/sites-available/www.conf /etc/nginx/sites-enabled/www.conf
		sudo systemctl start nginx
	fi
}
