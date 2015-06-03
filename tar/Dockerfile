FROM zmre/java-ubuntu:oraclejdk-7
MAINTAINER IronCore Labs

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8

ENV HBASE_VERSION 0.98.12.1
ENV HBASE_URL http://apache.cs.utah.edu/hbase/${HBASE_VERSION}/hbase-${HBASE_VERSION}-hadoop2-bin.tar.gz
ENV PHOENIX_VERSION 4.4.0-HBase-0.98
ENV PHOENIX_URL http://apache.cs.utah.edu/phoenix/phoenix-${PHOENIX_VERSION}/bin/phoenix-${PHOENIX_VERSION}-bin.tar.gz

RUN mkdir -p /opt
WORKDIR /opt

# Download HBase
RUN wget ${HBASE_URL}
RUN tar zxf hbase-${HBASE_VERSION}-hadoop2-bin.tar.gz && \
	rm hbase-${HBASE_VERSION}-hadoop2-bin.tar.gz && \
	ln -s hbase-${HBASE_VERSION}-hadoop2 hbase

# Download Phoenix
RUN wget "$PHOENIX_URL"
RUN tar zxf phoenix-${PHOENIX_VERSION}-bin.tar.gz && \
    rm phoenix-${PHOENIX_VERSION}-bin.tar.gz && \
    cp phoenix-${PHOENIX_VERSION}-bin/phoenix-${PHOENIX_VERSION}-server.jar /opt/hbase/lib && \
    ln -s phoenix-${PHOENIX_VERSION}-bin phoenix

# Sadly, can't run hbase in foreground until 1.1 so we will use the startup scripts to start it
RUN mkdir -p /etc/my_init.d
ADD hbase.sh /etc/my_init.d/hbase

# Setup JAVA_HOME. Because of how we installed java, we should just be able to use /usr
RUN sed -i.bak -e 's@.*export JAVA_HOME=.*@export JAVA_HOME=/usr@' /opt/hbase/conf/hbase-env.sh

# Setup
ADD hbase-site.xml /opt/hbase/conf/hbase-site.xml
RUN sed -i.bak -e 's@.*export HBASE_MANAGES_ZK=.*@export HBASE_MANAGES_ZK=true@' /opt/hbase/conf/hbase-env.sh
RUN sed -i.bak -e 's@.*export HBASE_HEAPSIZE=.*@export HBASE_HEAPSIZE=1G@' /opt/hbase/conf/hbase-env.sh
RUN echo "export HBASE_LOGOUT=/dev/stderr" >> /opt/hbase/conf/hbase-env.sh
ADD log4j.properties /opt/hbase/conf/log4j.properties

# Default cmd is my_init, which will launch cron, syslog, and hbase standalone

# HBase master web UI
EXPOSE 60010
# HBase region port
EXPOSE 60020
# HBase region web UI
EXPOSE 60030
# Zookeeper
EXPOSE 2181


