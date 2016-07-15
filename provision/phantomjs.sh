#!/bin/bash

if [ -f "/opt/phantomjs/bin/phantomjs" ]; then
	echo "INFO: PhantomJS is already installed"
else
	echo "INFO: Installing PhantomJS"
	wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 -nv
	tar -xvf phantomjs-2.1.1-linux-x86_64.tar.bz2
	rm phantomjs-2.1.1-linux-x86_64.tar.bz2
	sudo mv phantomjs-2.1.1-linux-x86_64 /opt/phantomjs
	sudo chown -R www-data:www-data /opt/phantomjs
	sudo chmod -R 755 /opt/phantomjs
fi
