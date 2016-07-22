#!/bin/bash

## You can call the shared install scripts
/provision/apt.sh
/provision/motd.sh
/provision/nginx.sh

## Or custom commands
echo "Done !"
