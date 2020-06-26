# 文件名Dockerfile，将一下内容直接写到Dockerfile里。（没有后缀名，注意名字不可以改）

# 如果你前面建立了centos的基础镜像，那么使用FROM 基础镜像名
# 刚才跳过了第一步，还没有对应基础镜像
# 可以直接使用FROM centos（但这种方式是从官网下载内容，太慢了，动不动就timeout）
# 如果这样还是timeout，可以使用 FROM docker.io/centos
# 当然我是前面两种写法都timeout了，所以我用了网易的源，如下
FROM centos

# 维护人信息
MAINTAINER gaozhonglei

#给基础镜像centos安装必备的环境
# 加上“rpm --rebuilddb &&”是为了防止数据库损坏而影响yum安装。
# 注意，比较保险的做法是有多少个yum命令，就加多少个“rpm --rebuilddb &&”在yum前面。
# 另外yum install一定要安装的是pcre，zlib，net-tools，make，gcc，wget，tar及其相关内容
RUN rpm --rebuilddb && yum install -y autoconf automake make wget proc-devel net-tools zlib zlib-devel make gcc  g++ openssl-devel pcre pcre-devel tar

# 在线获取nginx压缩包（也可以在本地系统（centos）里先下载压缩包，再ADD命令将包加入到基础镜像/usr/src目录中）
RUN wget http://nginx.org/download/nginx-1.19.0.tar.gz

# 解压到当前目录
RUN tar -zxvf nginx-1.19.0.tar.gz

# 设置环境
WORKDIR nginx-1.19.0

# 配置nginx
RUN ./configure --prefix=/usr/local/nginx && make && make install
# RUN rm -rf /usr/src/nginx

# 设置环境
WORKDIR /usr/local/nginx

#http
EXPOSE 80           
             
CMD ["nginx", "-g", "daemon off;"]