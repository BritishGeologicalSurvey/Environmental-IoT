#!/bin/sh
# Populate the local mongo database with the data
cd /vagrant/data
mkdir envdata
tar -xvf /vagrant/data/envdata.tar.gz -C envdata
mongorestore envdata
