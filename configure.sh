#! /bin/bash

if [ $# -ne 1 ]
then
  echo "usage: configure <number of servers>"
  exit -1
fi

SERVER_COUNT=$1

while read -ra line
do
	MACHINE=${line[0]}
	IP=${line[1]}
	IPS+=($IP)
	MACHINES+=($MACHINE)
done < <(fleetctl list-machines -l  | tail +2 | tail -$SERVER_COUNT)

ALLIPS=$(IFS=","; echo "${IPS[*]}")
echo $ALLIPS

INDEX=0
while [ $INDEX -lt $SERVER_COUNT ]
do
	ID=$(($INDEX+1))
	MACHINE=${MACHINES[$INDEX]}
	IP=${IPS[$INDEX]}
	THISIPS=$(echo $ALLIPS | sed "s/$IP/zookeeper-$ID/")
	echo "Setting server $ID as $MACHINE ($IP)"
	sed -e "s/#ZK_SERVERS#/$THISIPS/" -e "s/#MACHINE_ID#/$MACHINE/" zookeeper.service.template > zookeeper@$ID.service
	let INDEX=INDEX+1
done



