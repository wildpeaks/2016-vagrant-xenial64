#!/bin/bash

dpkg -s "imagemagick" >/dev/null 2>&1 && {
	echo "INFO: ImageMagick is already installed"
} || {
	echo "INFO: Installing ImageMagick.."
	sudo apt-get install imagemagick -y > /dev/null
}
