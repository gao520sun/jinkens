
docker build -t nginx:1.0 .

docker ps -a|grep "mynginx" | awk '{print $1}' | xargs docker stop

docker ps -a|grep "mynginx" | awk '{print $1}' | xargs docker rm

docker run -d --name=mynginx -p 80:80 -p 8082:8082 -p 8083:8083 nginx:1.0

#docker rmi $(docker images -a|grep none|awk '{print $3}')