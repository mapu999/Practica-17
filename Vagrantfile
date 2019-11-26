Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/xenial64"
    config.vm.provider "virtualbox" do |vb|
        vb.gui = true
        vb.name = "UbuntuServer"
        vb.memory = "2048"
    end
    config.vm.hostname = "lamp"
    config.vm.network "private_network", type: "dhcp"      
	#config.vm.network "forwarded_port", guest: 80, host: 8080
	#config.vm.network "forwarded_port", guest: 3306, host: 33366
    config.vm.provision "shell", path: "provision-for-apache-mysql.sh"
end


