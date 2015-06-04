# HBase + Apache Phoenix from Tarball

So because of how this was built, there are a few things you need to know to run it.  For one thing, I didn't bother to link anything from standard PATHs.  No biggie, but you need to know where to find things.  Also, this image is really just for local development and testing.  It uses HBase in pseudo-distributed mode, which basically means it is running three processes on one machine (zookeeper, hbase master, hbase region server).  It is not setup to run HDFS, but is using the local filesystem's `/data` directory to store things.  If you want data to persist, you'll need to map that out as a volume to something that persists across container runs.

To run it, you want to redirect some of the ports.  I generally run it like this:

    docker run -p 2181:2181 -p 16000:16000 -p 16010:16010 -p 16020:16020 -p 16030:16030 -h hbase --name hbase -d zmre/hbase-phoenix-ubuntu:oraclejdk7-hbase1.1-psuedodistrib

Note: the `name` thing above is mainly there just to make this example easy to follow.

Then to do common things like firing up the hbase shell or the phoenix sql command line shell, just find the right binaries.  Here is an example that drops you into bash and then fires up the hbase shell and then the phoenix shell.  You can also connect an external phoenix to this container such as Squirrel SQL.

    docker exec -it hbase bash -il
    cd /opt/hbase
    bin/hbase shell
    cd /opt/phoenix
    bin/sqlline.py localhost

The first time you connect to phoenix (via the shell or however) a bunch of tables are created in HBase.  This can take some extra time.

Also note that if you wanted to take this and use it as a base for building a production container, please do consider running the daemons as specific users.  Out of laziness and for the dev use case, I'm running them here as root.

