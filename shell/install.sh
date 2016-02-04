#!/bin/sh

apt-get update

apt-get install -y build-essential
apt-get install -y libkrb5-dev

curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
apt-get install -y nodejs mongodb

npm install -g node-inspector
