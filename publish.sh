
docker build . -t centos:1.0
docker run -d --name=mycentos -p 49002:49002 centos:1.0 /bin/bash
docker rmi $(docker images -a|grep none|awk '{print $3}')