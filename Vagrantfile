
# TODO one json per boxes subfolder instead, and the boxId is deduced from the folder name
boxes = JSON.parse(IO.read("boxes.json", encoding: "utf-8"))


Vagrant.configure(2) do |configs|
	boxes.each do |box|
		boxId = box["id"]

		configs.vm.define boxId, autostart: box["autostart"] do |config|
			config.vm.box = "ubuntu/xenial64"
			config.vm.box_check_update = false

			box["ports"].each do |port|
				config.vm.network "forwarded_port", guest: port["guest"], host: port["host"]
			end

			config.vm.provider "virtualbox" do |vb|
				vb.name = box["title"]
				vb.memory = box["memory"]
			end

			# @warning Quickhack to detect if the box is already fixed:
			# http://stackoverflow.com/questions/24855635/check-if-vagrant-provisioning-has-been-done
			if File.exist?(".vagrant/machines/#{boxId}/virtualbox/action_provision")

				if File.directory?("./boxes/#{boxId}")
					config.vm.synced_folder "./boxes/#{boxId}", "/setup", create: true
				end

				box["folders"].each do |folder|
					config.vm.synced_folder folder["host"], folder["guest"], create: true, owner: folder["owner"], group: folder["group"]
				end

				box["provision"].each do |provisionId|
					config.vm.provision "shell", name: provisionId, privileged: false, path: "provision/#{provisionId}.sh"
				end
			else

				# Until Ubuntu unfucks its cloud image
				config.vm.provision "shell", name: "Fix the box", privileged: false, path: "provision/fix.sh"
			end
		end
	end
end
