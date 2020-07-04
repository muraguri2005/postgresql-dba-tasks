Log in as sudo:
```bash 
sudo -s
```
Stop postgresql server
```bash 
service postgresql stop
```
Backup posgresql data:
```bash 
mv /var/lib/postgresql/version_number/main/ /var/lib/postgresql/version_number/main_old
```
Before running the tasks below make sure that you have enabled replication_user to be executed from the standby server. Check instructions [here](../allow-replication-user-access-from-standby-server).
For cloud virtual servers, you might need to whitelist the ip of the standby database on the primary ip security group or networking depending on the platform. For more information, please check the links below depending on your platform:
* AWS - [Authorizing Inbound Traffic for Your Linux Instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/authorizing-access-to-an-instance.html)
* Azure - [Security groups](https://docs.microsoft.com/en-us/azure/virtual-network/security-overview)

Bootstrap your standby server using backup from the primary database:
```bash
 sudo -u postgres pg_basebackup -h primary_database_ip -D /var/lib/postgresql/version_number/main -U replication_user_username -v -P --xlog-method=stream
```
Edit postgresql.conf:
```bash
 nano /etc/postgresql/version_number/main/postgresql.conf
```
Edit corresponding property as below:
```bash
hot_standby = on
```
Copy sample recovery file:
```bash
cp -avr /usr/share/postgresql/version_number/recovery.conf.sample /var/lib/postgresql/version_number/main/recovery.conf
```
Edit the recovery.conf file:
```bash
nano /var/lib/postgresql/9.6/main/recovery.conf
```
Edit the properties below with corresponding values:
```bash 
standby_mode = on
primary_conninfo = 'host=primary_database_ip port=5432 user=replication_user_username password=replication_user_password'
trigger_file = '/tmp/postgresql.trigger.5432'
```
Restart postgresql:
```bash
service postgresql start
```
To confirm that the server has restarted and has been set successfully tail the postgresql logs:
```bash 
tail -f /var/log/postgresql/postgresql-version_number-main.log
```


