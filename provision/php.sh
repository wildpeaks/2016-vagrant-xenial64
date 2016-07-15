#!/bin/bash

dpkg -s "php7.0-fpm" >/dev/null 2>&1 && {
	echo "INFO: PHP 7 is already installed"
} || {
	echo "INFO: Installing PHP 7..."
	sudo apt-get install php7.0-fpm -y > /dev/null
	sudo apt-get install php7.0-curl php7.0-json -y > /dev/null
}
