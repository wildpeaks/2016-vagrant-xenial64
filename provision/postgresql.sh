#!/bin/bash

dpkg -s "postgresql-9.5" >/dev/null 2>&1 && {
	echo "INFO: PostgreSQL 9.5 is already installed"
} || {
	echo "INFO: Installing PostgreSQL 9.5..."
	sudo apt-get install postgresql-9.5 -y > /dev/null

	# Forces UTF-8 encoding
	sudo pg_dropcluster --stop 9.5 main
	sudo pg_createcluster --encoding=UTF8 --locale=en_US.utf-8 --start 9.5 main
	sudo systemctl stop postgresql
	sudo systemctl start postgresql
}
