Log in as postgres user on the database server:
```bash
sudo su postgres
```

Open the pd_hba_conf
```bash
nano /etc/postgresql/version_number/main/pg_hba.conf
```

Add the line below:
```bash
host     replication     replication_user_username  standby_server_ip/32        md5
```