#! /bin/sh

ID=1
docker run \
	--rm \
	--name zookeeper-$ID \
	--env ZK_SERVER_NUMBER=$ID \
	--hostname zookeeper-$ID \
	--env ZK_SERVERS="zookeeper-1,zookeeper-2,zookeeper-3" \
	--publish 2181:2181 \
	--publish 2888:2888 \
	--publish 3888:3888 \
	--volume /mnt/sda/data/zookeeper:/data \
	nrandell/zookeeper-centos
