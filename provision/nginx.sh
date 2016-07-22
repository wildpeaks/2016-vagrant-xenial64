#!/bin/bash

dpkg -s "nginx" >/dev/null 2>&1 && {
	echo "INFO: Nginx is already installed"
} || {
	echo "INFO: Installing Nginx..."

	sudo adduser ubuntu www-data
	sudo apt-get install nginx -y > /dev/null
}


# Makes sure we loop over real files only
shopt -s nullglob

has_sites=false
for filename in /box/sites-available/*.conf; do
	has_sites=true
	break
done


if [ "$has_sites" = true ]; then
	echo "INFO: Setting up Nginx sites..."

	# Removes existing sites
	sudo rm -rf /etc/nginx/sites-enabled/*
	sudo rm -rf /etc/nginx/sites-available/*

	# Adds the site configs from the box
	for filename in /box/sites-available/*.conf; do
		name=`basename "$filename"`
		sudo cp /box/sites-available/$name /etc/nginx/sites-available/$name
		sudo ln -s /etc/nginx/sites-available/$name /etc/nginx/sites-enabled/$name
	done

	# Makes sure Nginx is running, and uses the new configs
	nginx_active=`systemctl is-active nginx >/dev/null 2>&1 && echo YES || echo NO`
	if [ $nginx_active = "YES" ]; then
		sudo systemctl reload nginx
	else
		sudo systemctl start nginx
	fi
fi
