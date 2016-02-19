# Environmental-IoT

Understanding and Managing the Natural Environment through Internet of Things Technology

## Setting up the project

    # This works best if the host machine is linux or mac based
    # As there are issues with using node.js on a windows file system (symbolic links/file path length)

    # Install Virtualbox and Vagrant from:
    https://www.virtualbox.org/
    https://www.vagrantup.com/

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

   ansible-playbook ansible/live.yaml --ask-sudo-pass