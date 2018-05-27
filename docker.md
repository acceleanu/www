# Docker 
- [Official Documentation](https://docs.docker.com)

## docker engine
- one docker container for each process in the stack 
- manages containers on the local machine
- images == saved states of containers - that is every image is what once was a container that someone committed into an image
- copy-on-write filesystem
```
$ docker pull centos/mongodb-36-centos7 && docker history centos/mongodb-36-centos7
```

| **Docker**         | vs            | **Git**  |
| -------------: |:-------------:| :----|
| Image          | *saved state*              | Commit |
| Container      | *used for local execution* | Checkout |
| Repository     | *collection of commits*    | Repository |
| Docker hub     | *popular remote server*    | Github | 

### Basic Commands
- **docker run**
```
$ docker run --help
```
```
$ docker run busybox /bin/echo 'hello world!' 
```
```
$ docker run busybox ping google.com
```

- interact with the container
```
$ docker run -it ubuntu /bin/bash
```

- expose port 80 from the container as port 8000 on the host machine
```
$ docker run -p 8000:80 nginx
```

- run in detached mode
```
$ docker run -d -p 8000:80 nginx
```

- give a name to the container
```
$ docker run -d -p 8000:80 --name webserver nginx
```

- show logs
```
$ docker logs -f webserver
```

- stop a container
```
$ docker ps -a
$ docker stop webserver
```

- start a container
```
$ docker ps -a
$ docker start webserver
```

- attach to a running container
```
$ docker attach webserver
```

- remove all instances
```
$ docker rm -f $(docker ps -aq)
```

- find port mappings
```
$ docker port webserver
```

- find changes in the container vs the image that the container has been started from
```
$ docker diff webserver
```

- copy files from the container
```
$ docker cp webserver:/usr/share/nginx/html/index.html .
```

- get detailed info about a container
```
$ docker inspect webserver
```

## docker hub
- Common registry of docker images
- [Docker Registry official documentation](https://docs.docker.com/registry)
- [Docker registry is an apache open source project](https://github.com/docker/distribution)

- Searching for images on the local machine
```
$ docker search mongodb
```
- [Search for images on docker hub](https://hub.docker.com)

- pull image to local machine
```
$ docker pull postgres:latest
```
- commit and push image to docker hub
```
$ docker login # if not yet logged in
$ docker commit -m 'description of the change' <container_id> <tag_name>
$ docker tag <tag_name> <my_docker_hub_user>/<tag_name>
$ docker push <my_docker_hub_user>/<tag_name>
```


