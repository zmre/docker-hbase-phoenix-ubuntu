# HBase + Apache Phoenix from Tarball

So because of how this was built, there are a few things you need to know to run it.  For one thing, I didn't bother to link anything from standard PATHs.  No biggie, but you need to know where to find things.  Also, this image is really just for local development and testing.  It uses HBase in standalone mode (single machine, no HDFS).  Unless you do something to add volumes, you'll be starting with a blank HBase data slate every time you start the container.

To run it, you want to redirect some of the ports.  I generally run it like this:

    docker run -p 2181:2181 -p 16010:16010 -p 16020:16020 -p 16030:16030 -h hbase --name hbase -d zmre/hbase-phoenix-ubuntu:oraclejdk7-hbase1.1

Note: the `name` thing above is mainly there just to make this example easy to follow.

Then to do common things like firing up the hbase shell or the phoenix sql command line shell, you can either go straight from docker to one of the shells, or drop to a bash shell and then to the next spot.  You'll figure it out.  Here's an example starting with bash:

    docker exec -it hbase bash -il
    cd /opt/hbase
    bin/hbase shell
    cd /opt/phoenix
    bin/sqlline.py localhost

The first time you connect to phoenix (via the shell or however) a bunch of tables are created in HBase.  This can take some extra time.
