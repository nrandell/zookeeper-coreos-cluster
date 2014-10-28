#! /bin/bash

if [ $# -ne 1 ]
then
  echo "usage: configure <number of servers>"
  exit -1
fi

SERVER_COUNT=$1

for i in $(seq 1 $SERVER_COUNT)
do
	let id=i-1
	SERVER[$id]="linode-london-infrastructure-$i.linode.nickrandell.me"
done


SERVERS=$(IFS=','; echo "${SERVER[*]}")

rm zookeeper*.service


INDEX=0
while [ $INDEX -lt $SERVER_COUNT ]
do
	ID=$(($INDEX+1))
	THIS_SERVERS=$(echo $SERVERS | sed "s/${SERVER[$INDEX]}/0.0.0.0/")
	sed -e "s/#ZK_SERVERS#/$THIS_SERVERS/" zookeeper.service.template > zookeeper@$ID.service
	let INDEX=INDEX+1
done



