ssh to the Primary Database server
```bash
sudo -u postgres psql
```
Create user command:
```sql
create user user_username with encrypted password 'plain_text_password';
```
Grant usage on the schema that contains the tables they need read access to:
```sql
GRANT USAGE on SCHEMA schema_name to user_username;
```
Grant read on the tables or views that the user needs to have access to
```sql
GRANT SELECT on table_name to user_username;
```
Grant read on all tables:
```sql
GRANT SELECT ON ALL TABLES IN SCHEMA schema_name TO user_username;
```
