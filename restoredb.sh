#!/usr/bin/env bash

USER="root"
PASSWORD="root"

databases=`ls -1 /vagrant/databases/*.sql`

for db in $databases; do
    echo "Importing $db ..."
    sudo mysql -u $USER -p$PASSWORD < $db
done