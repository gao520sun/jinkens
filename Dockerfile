FROM nginx
LABEL maintainer "gaozhonglei"
#COPY ./build/ /usr/share/nginx/html/
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

EXPOSE 8080
#EXPOSE 8082

EXPOSE 8083