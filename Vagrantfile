# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "nercceh/ubuntu14.04"

  config.vm.synced_folder ".", "/opt/iot", mount_options: ['dmode=777', 'fmode=777']

  config.vm.network "forwarded_port", guest: 3000, host: 3000
  config.vm.network "forwarded_port", guest: 8080, host: 8080
  config.vm.network "forwarded_port", guest: 5858, host: 5858
  config.vm.network "forwarded_port", guest: 1234, host: 1234

  config.vm.provision "ansible_local" do |ansible|
    ansible.provisioning_path = "/opt/iot/ansible/"
    ansible.verbose        = true
    ansible.install        = true
    ansible.playbook = "vagrant.yaml"
  end
end
