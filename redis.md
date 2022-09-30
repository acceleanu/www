# redis

## install
```
wget http://download.redis.io/releases/redis-7.0.5.tar.gz
tar -zxvf redis-7.0.5.tar.gz
cd redis-7.0.5
make
make test
```

## config
bind 127.0.0.1

## commands
- acl list
- acl setuser root on resetpass >newpass123 allcommands allkeys
- auth root newpass123
- acl set user default off
- config rewrite 
- acl cat

## run
```
./redis-server ./redis.conf
./redis-cli
```

## links
- [User Setup/ACLs](https://redis.com/blog/getting-started-redis-6-access-control-lists-acls/)
- [ACLs](https://redis.io/docs/manual/security/acl/)
- [Admin](https://redis.io/docs/manual/admin/)


