
docker build . -t jenkins:web
docker save jenkins:web -o fengyu
docker ps -a|grep "fengyu-web" | awk '{print $1}' | xargs jenkins stop
docker ps -a|grep "fengyu-web" | awk '{print $1}' | xargs jenkins rm
docker run -d --name=fengyu-web -p 49002:49002 fengyu:web
docker rmi $(docker images -a|grep none|awk '{print $3}')