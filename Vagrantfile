# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.network :private_network, ip: "192.168.24.100"
  config.ssh.forward_agent = true

  config.vm.hostname = "vagrant.local"

  config.vm.provider :virtualbox do |vb|
     # 1024 MB ram is way better
     vb.customize ["modifyvm", :id, "--memory", "1024"]
     # 2 cpus is better, too
     vb.customize ["modifyvm", :id, "--cpus", "2"]
     vb.customize ["modifyvm", :id, "--ioapic", "on"]
  end
end

