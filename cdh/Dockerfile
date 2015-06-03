FROM zmre/java-ubuntu:oraclejdk-7
MAINTAINER IronCore Labs

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8

#ENV HBASE_VERSION 1.0.0+cdh5.4.2+142-1.cdh5.4.2.p0.4~trusty-cdh5.4.2
ENV HBASE_VERSION 0.98.6+cdh5.3.3+85-1.cdh5.3.3.p0.8~trusty-cdh5.3.3
#ENV PHOENIX_VERSION 4.4.0-HBase-1.0
ENV PHOENIX_VERSION 4.4.0-HBase-0.98
ENV PHOENIX_BINARIES http://mirrors.ibiblio.org/apache/phoenix/phoenix-${PHOENIX_VERSION}/bin/phoenix-${PHOENIX_VERSION}-bin.tar.gz


WORKDIR /root
RUN echo "deb [arch=amd64] http://archive.cloudera.com/cdh5/ubuntu/trusty/amd64/cdh trusty-cdh5.3.3 contrib" > /etc/apt/sources.list.d/cloudera.list
RUN echo "deb-src http://archive.cloudera.com/cdh5/ubuntu/trusty/amd64/cdh trusty-cdh5.3.3 contrib" >> /etc/apt/sources.list.d/cloudera.list
RUN wget http://archive.cloudera.com/cdh5/ubuntu/trusty/amd64/cdh/archive.key -O /root/archive.key && apt-key add /root/archive.key && rm /root/archive.key
ADD cloudera.pref /etc/apt/preferences.d/cloudera.pref

RUN apt-get update
RUN apt-get install -y hbase="$HBASE_VERSION" hbase-master="$HBASE_VERSION"

RUN wget "$PHOENIX_BINARIES" -O /root/phoenix.tar.gz && \
    cd /root && tar zxf phoenix.tar.gz && \
    cd phoenix-${PHOENIX_VERSION}-bin && \
    cp phoenix-${PHOENIX_VERSION}-server.jar /usr/lib/hbase && \
    rm /root/phoenix.tar.gz

# Sadly, can't run hbase in foreground until 1.1 so we will use the startup scripts to start it
RUN mkdir -p /etc/my_init.d
ADD hbase.sh /etc/my_init.d/hbase

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# HBase master
EXPOSE 60000
# HBase master web UI
EXPOSE 60010
EXPOSE 60020
EXPOSE 60030
# Zookeeper
EXPOSE 2181

