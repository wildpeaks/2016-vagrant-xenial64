
Vagrant.configure(2) do |configs|

	## Boxes subfolders
	Dir.chdir('boxes')
	boxIds = Dir.glob('*').select { |boxId| File.exist? "#{boxId}/box.json" }
	Dir.chdir('..')

	boxIds.each {
		|boxId|
		box = JSON.parse(IO.read("./boxes/#{boxId}/box.json", encoding: "utf-8"))
		configs.vm.define boxId, autostart: box["autostart"] do |config|

			## Ubuntu 16.04
			config.vm.box = "ubuntu/xenial64"
			config.vm.box_check_update = false

			## Forwarded ports
			box["ports"].each do |port|
				config.vm.network "forwarded_port", guest: port["guest"], host: port["host"]
			end

			## Virtualbox settings
			config.vm.provider "virtualbox" do |vb|
				vb.name = box["title"]
				vb.memory = box["memory"]
			end

			if File.exist?(".vagrant/machines/#{boxId}/virtualbox/action_provision")

				## Shared folders
				config.vm.synced_folder "./boxes/#{boxId}/", "/box", create: true, owner: 'root', group: 'root'
				box["folders"].each do |folder|
					hostPath = folder["host"]
					config.vm.synced_folder "./boxes/#{boxId}/#{hostPath}", folder["guest"], create: true, owner: folder["owner"], group: folder["group"]
				end

				## Provision script
				if File.exist?("./boxes/#{boxId}/provision.sh")
					config.vm.synced_folder "./provision/", "/provision", create: true
					config.vm.provision "shell", name: "Provision Script", privileged: false, path: "./boxes/#{boxId}/provision.sh"
				end
			else

				## Fix hosts
				config.vm.provision "shell", name: "Add the missing host", privileged: true, :inline => <<-SHELL
					echo "127.0.0.1 ubuntu-xenial" >> /etc/hosts
				SHELL
			end
		end
	}
end
