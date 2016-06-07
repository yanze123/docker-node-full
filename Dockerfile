# 设置基础镜像
FROM daocloud.io/library/ubuntu

# 安装 NodeJS 和 npm
RUN apt-get update
RUN apt-get install -y nodejs npm

# 由于 apt-get 下载的 Node 实际上是 nodejs，所以要创建一个 node 的快捷方式
RUN ln -s /usr/bin/nodejs /usr/bin/node

# 安装 Git
RUN apt-get install -y git

# 安装 Mongodb（来自官方教程）
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
RUN echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/mongodb.list
RUN apt-get update
RUN apt-get install -y mongodb

# 设置工作目录
WORKDIR /srv/full

# 清空已存在的文件（如果有）
RUN rm -rf /srv/full

# 通过 Git 下载准备好的 MEAN 架构的网站代码
RUN git clone https://github.com/yanze123/movietest.git .

# 安装 NodeJS 依赖库
RUN npm install --production

# 创建 mongodb 数据文件夹
RUN mkdir -p /data/db

# 暴露端口（分别是 NodeJS 应用和 Mongodb）
EXPOSE 3000 27017

# 设置 NodeJS 应用环境变量
ENV NODE_ENV=production PORT=3000

# 添加启动脚本
ADD start.sh /tmp/
RUN chmod +x /tmp/start.sh

# 设置启动时默认运行命令
CMD ["bash", "/tmp/start.sh"]