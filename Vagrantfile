# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = "torquebox"
  config.vm.forward_port 80, 8000
  config.vm.forward_port 8080, 8080
  config.vm.customize ["modifyvm", :id, "--memory", 1024]
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.module_path = "puppet/modules"
    puppet.manifest_file = "site.pp"
  end
end
