# Reset password

- go the folder of your postgres database and make a backup of the pg_hba config file:
```
cd /var/lib/pgsql/9.6/data/
cp pg_hba.conf pg_hba.conf.org
```

- restart postgres
```
/etc/rc.d/rc.postgresql restart
```

- comment the first config line and add this one instead:
```
# TYPE  DATABASE        USER            ADDRESS                 METHOD
local  	all   			all   			trust
```

- change the password by running: 
```
$ psql
# ALTER USER Postgres WITH PASSWORD '<newpassword>';
```

- change the config back to: 
```
# TYPE  DATABASE        USER            ADDRESS                 METHOD
local   all             all                                     md5
```

- restart postgres
```
/etc/rc.d/rc.postgresql restart
```



