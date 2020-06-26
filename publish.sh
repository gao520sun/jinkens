
docker build . -t jenkins:web
docker save jenkins:web -o jenkins
docker ps -a|grep "jenkins-web" | awk '{print $1}' | xargs docker stop
docker ps -a|grep "jenkins-web" | awk '{print $1}' | xargs docker rm
docker run -d --name=jenkins-web -p 49002:49002 jenkins:web
docker rmi $(docker images -a|grep none|awk '{print $3}')