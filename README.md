# vagrant-xenial64-boilerplate

Vagrantfile for [ubuntu/xenial64](https://atlas.hashicorp.com/ubuntu/boxes/xenial64/) Virtualbox boxes, with working **synced_folder**, and JSON configurations.


---

## Start the virtual machines

First install the [vbguest plugin](https://rubygems.org/gems/vagrant-vbguest) (if you don't have it already) using:

	vagrant plugin install vagrant-vbguest

Then initialize the boxes with:

	vagrant up
	vagrant reload --provision


---

## Boxes

Boxes are defined by adding a subfolder in folder `boxes` (the name of the folder is the id of the box).
The subfolder should contain a `box.json` file, can also have an optional `provision.sh` file.
It also gets mounted as `/box`, so you can store box-specific files (such as a Nginx virtual host config used) for provisioning.

The JSON file contains the definition of a single virtual machine.
Example:

	{
		"title": "CI Server",
		"memory": 512,
		"autostart": true,
		"ports": [
			{"host": 8080, "guest": 80}
		],
		"folders": [
			{"host": "www", "guest": "/var/www/box1", "owner": "www-data", "group": "www-data"}
		]
	}

Note that the "host" paths of shared folders are relative to the box folder, not the location of *Vagrantfile*.


---

## Provisioning

If a file `provision.sh` exists in the box folder, it is runs after the synced folders have been setup.

The `provision` folder (mounted as `/provision`) is a set of **shell scripts** to install popular applications (such as Nginx or PHP 7) that `provision.sh` can optionally use.


---
