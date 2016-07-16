
Vagrant.configure(2) do |config|
	boxId = "firstbox"
	config.vm.define boxId, autostart: true do |mybox|
		mybox.vm.box = "ubuntu/xenial64"
		mybox.vm.box_check_update = true

		mybox.vm.network "forwarded_port", guest: 80, host: 8080

		mybox.vm.provider "virtualbox" do |vb|
			vb.name = "Boilerplate"
			vb.memory = 512
		end

		# http://stackoverflow.com/questions/24855635/check-if-vagrant-provisioning-has-been-done
		if File.exist?(".vagrant/machines/#{boxId}/virtualbox/action_provision")

			puts "-----------------------------------------------"
			puts "WITH SHARED FOLDER"
			puts "-----------------------------------------------"
			mybox.vm.synced_folder "./myfiles", "/var/www/myfiles", create: true, owner: "www-data", group: "www-data"

		else

			puts "-----------------------------------------------"
			puts "WITHOUT SHARED FOLDER"
			puts "-----------------------------------------------"

			mybox.vm.provision "shell", privileged: true, :inline => <<-SHELL
				echo "127.0.0.1 ubuntu-xenial" >> /etc/hosts
			SHELL

			mybox.vm.provision "shell", privileged: false, :inline => <<-SHELL
				sudo apt-get update
				sudo apt-get upgrade -y
				sudo apt-get install -y build-essential linux-headers-generic linux-headers-`uname -r`
				cd /tmp
				wget http://download.virtualbox.org/virtualbox/5.0.24/VBoxGuestAdditions_5.0.24.iso -nv
				sudo mount -o loop,ro VBoxGuestAdditions_5.0.24.iso /mnt
				sudo /mnt/VBoxLinuxAdditions.run --nox11
				sudo umount /mnt
				rm VBoxGuestAdditions_5.0.24.iso
				echo "-----------------------------------------------"
				echo "VBoxGuestAdditions was installed."
				echo "-----------------------------------------------"
			SHELL
		end

	end
end