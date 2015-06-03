#!/bin/sh
# This is just a stub so my_init fires things up
#exec /opt/hbase/bin/start-hbase.sh
echo $HOSTNAME > /opt/hbase/conf/regionservers
exec /opt/hbase/bin/hbase-daemon.sh --config /opt/hbase/conf foreground_start master
