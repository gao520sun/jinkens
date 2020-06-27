FROM centos:latest
MAINTAINER gaozhonglie   #作者信息
WORKDIR /usr/local/src/      #工作目录
ENV NG_VERSION nginx-1.19.0  #定义环境变量

RUN yum -y install epel-release     #安装epel仓库
RUN yum -y install wget  && wget http://nginx.org/download/$NG_VERSION.tar.gz && tar xzvf $NG_VERSION.tar.gz   #下载nginx文件并解压

 #安装编译依赖包
RUN yum install -y gcc gcc-c++ glibc make autoconf openssl openssl-devel && yum install -y pcre-devel  libxslt-devel gd-devel GeoIP GeoIP-devel GeoIP-data
RUN yum clean all  #清理仓库
RUN useradd -M -s /sbin/nologin nginx   #创建nginx用户
WORKDIR /usr/local/src/$NG_VERSION   #切换工作目录

#编译安装nginx
RUN ./configure --user=nginx --group=nginx --prefix=/usr/local/nginx --with-file-aio  --with-http_ssl_module  --with-http_realip_module    --with-http_addition_module    --with-http_xslt_module   --with-http_image_filter_module    --with-http_geoip_module  --with-http_sub_module  --with-http_dav_module --with-http_flv_module    --with-http_mp4_module --with-http_gunzip_module  --with-http_gzip_static_module  --with-http_auth_request_module  --with-http_random_index_module   --with-http_secure_link_module   --with-http_degradation_module   --with-http_stub_status_module && make && make install

# ADD index.html /usr/local/nginx/html   
VOLUME  /usr/local/nginx/html            #设置容器中要挂在到宿主机的目录
ENV PATH /usr/local/nginx/sbin:$PATH #设置sbin环境变量

EXPOSE 80/tcp                              
ENTRYPOINT ["nginx"]                  
CMD ["-g","daemon off;"]
#当ENTRYPOINT和CMD连用时，CMD的命令是ENTRYPOINT命令的参数，两者连用相当于nginx -g "daemon off;"而当一起连用的时候命令格式最好一致（这里选择的都是json格式的是成功的，如果都是sh模式可以试一下）
