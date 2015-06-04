FROM zmre/hbase-phoenix-ubuntu:oraclejdk7-hbase1.1
MAINTAINER IronCore Labs

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8

#ENV HADOOP_VERSION 2.7.0
#ENV HADOOP_URL http://apache.cs.utah.edu/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz
ENV ZK_VERSION 3.4.6
ENV ZK_URL http://apache.cs.utah.edu/zookeeper/zookeeper-${ZK_VERSION}/zookeeper-${ZK_VERSION}.tar.gz

#WORKDIR /opt
#RUN wget ${HADOOP_URL}
#RUN tar zxf hadoop-${HADOOP_VERSION}.tar.gz && \
#    ln -s hadoop-${HADOOP_VERSION} hadoop && \
#    rm hadoop-${HADOOP_VERSION}.tar.gz

RUN wget ${ZK_URL}
RUN tar zxf zookeeper-${ZK_VERSION}.tar.gz && \
    ln -s zookeeper-${ZK_VERSION} zookeeper && \
    rm zookeeper-${ZK_VERSION}.tar.gz

# Add phusion base specific startup script
RUN rm -rf /etc/service/hbase
#ADD hbase.sh /etc/service/hbase/run
ADD hbase.sh /etc/my_init.d/hbase

# Setup
ADD hbase-site.xml /opt/hbase/conf/hbase-site.xml
RUN mkdir /data
RUN sed -i.bak -e 's@.*export HBASE_MANAGES_ZK=.*@export HBASE_MANAGES_ZK=false@' /opt/hbase/conf/hbase-env.sh
RUN sed -i.bak -e 's@^.*export HBASE_LOGOUT=.*@@' /opt/hbase/conf/hbase-env.sh
ADD zoo.cfg /opt/zookeeper/conf/zoo.cfg

# Initialize phoenix, which requires starting the daemons
# Just using the performance test script to trigger the base table creations.
RUN /etc/my_init.d/hbase && \
    sleep 3 && \
    phoenix/bin/performance.py localhost 1 && \
    hbase/bin/stop-hbase.sh && \
    zookeeper/bin/zkServer.sh stop

# Default cmd is my_init, which will launch cron, syslog, and hbase

# HBase port, master web UI, regionserver port, regionserver UI, Zookeeper
EXPOSE 16000 16010 16020 16030 2181


