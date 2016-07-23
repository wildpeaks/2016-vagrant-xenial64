#!/bin/bash

dpkg -s "neo4j" >/dev/null 2>&1 && {
	echo "INFO: Neo4j is already installed"
} || {
	echo "INFO: Installing Neo4j..."
	wget -O - https://debian.neo4j.org/neotechnology.gpg.key | sudo apt-key add -
	echo 'deb http://debian.neo4j.org/repo stable/' > /tmp/neo4j.list
	sudo mv /tmp/neo4j.list /etc/apt/sources.list.d
	sudo apt-get update
	sudo apt-get install neo4j -y > /dev/null
}
