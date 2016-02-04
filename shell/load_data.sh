#!/bin/sh
# Populate the local mongo database with the data
cd /vagrant/data
mkdir envdata
tar -xvf /vagrant/data/envdata.tar.gz -C envdata
mongorestore envdata

# Copy over the map-locations.js
cp map-locations.js /vagrant/code/public/js/components/.