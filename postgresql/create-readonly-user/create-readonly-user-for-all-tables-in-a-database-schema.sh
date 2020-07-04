#!/usr/bin/env bash
echo "Enter username of the user"
read username
echo "Enter password of the $username"
read password
echo "Enter name of your database"
read databaseName
echo "Enter the name of your schema in $databaseName database:"
read schema
sudo -u postgres -H -- psql -c  "create user $username with encrypted password '$password';"
sudo -u postgres -H -- psql -d $databaseName -c  "GRANT USAGE on schema $schema to $username;"
sudo -u postgres -H -- psql -d $databaseName -c  "GRANT SELECT ON ALL TABLES in schema $schema TO $username;"
