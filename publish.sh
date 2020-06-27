
docker build -t centos_nginx:v1 .
# docker run -d --name=mynginx1.0 -p 80:80 nginx:1.0 /bin/bash
docker rmi $(docker images -a|grep none|awk '{print $3}')