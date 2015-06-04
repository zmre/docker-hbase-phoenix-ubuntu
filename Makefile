who-am-i := $(shell whoami)

raw:
	docker build -t zmre/hbase-phoenix-ubuntu:tar-oraclejdk7-hbase1.1-pseudodist tar

raw-run:
	a=`docker run -p 2181:2181 -p 16000:16000 -p 16010:16010 -p 16020:16020 -p 16030:16030 -h hbase -d zmre/hbase-phoenix-ubuntu:tar-oraclejdk7-hbase1.1-pseudodist` ; docker exec -it $$a bash -il ; docker stop $$a

all: raw
