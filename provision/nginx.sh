#!/bin/bash

dpkg -s "nginx" >/dev/null 2>&1 && {
	echo "INFO: Nginx is already installed"
} || {
	echo "INFO: Installing Nginx..."

	sudo adduser ubuntu www-data
	sudo apt-get install nginx -y > /dev/null

	## Only online needs to set ownership and permissions
	# chown -R ubuntu:www-data /var/www/*
	# chmod -R 775 /var/www/*

	#
	# TODO there might be multiple sites on the same box though
	#
	if [ -f "/setup/sites-available/www.conf" ]; then
		sudo systemctl stop nginx
		sudo rm /etc/nginx/sites-enabled/default
		sudo cp /setup/sites-available/www.conf /etc/nginx/sites-available/www.conf
		sudo ln -s /etc/nginx/sites-available/www.conf /etc/nginx/sites-enabled/www.conf
		## sudo ln -fs /etc/nginx/sites-available/www.conf /etc/nginx/sites-enabled/www.conf
		sudo systemctl start nginx
	fi
}
