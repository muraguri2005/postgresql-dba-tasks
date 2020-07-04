Log in as postgres user on the database server:
```bash
sudo su postgres
```
Create archiving directory:
```bash
mkdir -p archive_dir
```
Open postgresql.conf
```bash
nano /etc/postgres/version_number/main/postgresql.conf
```
Edit corresponding lines to look as below:
```
listen_addresses = '*'
wal_level = hot_standby
archive_mode = on
archive_command ='test ! -f archive_dir/%f && cp %p archive_dir/%f'
max_wal_senders = 3
```
Restart posgresql server:
```bash
service postgresql restart
```