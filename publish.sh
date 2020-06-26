
docker build . -t jenkins1:web
docker save jenkins1:web -o jenkins
docker ps -a|grep "jenkins1-web" | awk '{print $1}' | xargs docker stop
docker ps -a|grep "jenkins1-web" | awk '{print $1}' | xargs docker rm
docker run -d --name=jenkins1-web -p 49002:49002 jenkins1:web
docker rmi $(docker images -a|grep none|awk '{print $3}')