#!/bin/sh
# This is just a stub so my_init fires things up
#exec /opt/hbase/bin/start-hbase.sh
echo $HOSTNAME > /opt/hbase/conf/regionservers
/opt/zookeeper/bin/zkServer.sh start
sleep 1
/opt/hbase/bin/hbase-daemon.sh --config /opt/hbase/conf start master
sleep 1
/opt/hbase/bin/hbase-daemon.sh --config /opt/hbase/conf start regionserver
#sleep 1
#/opt/hbase/bin/hbase-daemon.sh --config /opt/hbase/conf start master-backup

#exec /opt/hbase/bin/start-hbase.sh
#exec /opt/hbase/bin/hbase-daemon.sh --config /opt/hbase/conf foreground_start master
