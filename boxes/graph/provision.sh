#!/bin/bash

## You can call the shared install scripts
/provision/apt.sh
/provision/motd.sh
/provision/neo4j.sh

## Or custom commands
echo "Done !"
