#!/usr/bin/env bash

USER="root"
PASSWORD="toor"

databases=`ls -1 /vagrant/database/*.sql`

for db in $databases; do
    echo "Importing $db ..."
    sudo mysql -u $USER -p$PASSWORD < $db
done