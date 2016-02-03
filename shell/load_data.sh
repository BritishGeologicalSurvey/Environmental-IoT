#!/bin/sh
# Populate the local mongo database with the data

mongoimport -d mydb -c everything --type csv --file /vagrant/data/All\ data\ 23-11-15\ to\ 21-12-15.csv --headerline
