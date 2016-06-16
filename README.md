# Environmental-IoT

Understanding and Managing the Natural Environment through Internet of Things Technology

## Setting up the project

    # This currently only works if the host machine is linux or mac based
    # As there are issues with using node.js on a windows file system (symbolic links/file path length) and ansible only runs on linux/mac

    # Install Virtualbox, Vagrant and Ansible on your local (host) machine from:
    https://www.virtualbox.org/
    https://www.vagrantup.com/

    # Fix Vagrant Bug 1
    https://github.com/mitchellh/vagrant/commit/9dbdb9397a92d4fc489e9afcb022621df7f60d11
    sudo nano /opt/vagrant/embedded/gems/gems/vagrant-1.8.1/plugins/provisioners/ansible/provisioner/guest.rb
    On Windows 7: C:\HashiCorp\Vagrant\embedded\gems\gems\vagrant-1.8.1\plugins\provisioners\ansible\provisioner\guest.rb
    
    # Fix Vagrant Bug 2 (windows only)
    https://github.com/mitchellh/vagrant/commit/07f3d0b00dabc37281a01c6776eed22daeea7066
    C:\HashiCorp\Vagrant\embedded\gems\gems\vagrant-1.8.1\plugins\provisioners\ansible\config\guest.rb

    # Clone Repo
    git clone https://github.com/BritishGeologicalSurvey/Environmental-IoT

    # Copy sensitive files not in repo
    cp envdata.tar.gz Environmental-IoT/data/.

    # Start Vagrant Machine
    cd Environmental-IoT
    vagrant up

    # Grab a Cuppa while dependancies are downloaded/compiled/installed!

    # Start the application in development mode
    vagrant ssh
    cd /opt/iot
    grunt develop

    # Test on web browser on host machine
    http://localhost:3000

## Using the Node inspector

    On VM SSH Run:
    node-inspector --no-preload

    On New VM SSH:
    cd /vagrant/
    node --debug-brk bin/www

    On Host Visit:
    http://127.0.0.1:8080/?ws=127.0.0.1:8080&port=5858 to start debugging.

    On Host Visit:
    http://localhost:3000/

## Deploying to live server using ansible

    # Edit your ansible hosts so that the iot server is present
    echo "nsb-iot.cloudapp.net" >> /etc/ansible/hosts

    ansible-playbook ansible/live.yaml --ask-sudo-pass
