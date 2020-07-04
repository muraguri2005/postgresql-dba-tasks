ssh to the Primary Database server
```bash
sudo -u postgres createuser -U postgres replication_user_username -P -c 5 --replication
```
This will prompt you to enter password for the user.