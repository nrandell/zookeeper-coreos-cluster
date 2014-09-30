FROM nrandell/openjre-centos
MAINTAINER Nick Randell <nick@nickrandell.com>

RUN wget -q -O - http://apache.mirrors.pair.com/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz | tar -xzf - -C /opt
ADD zoo.cfg.template /opt/zookeeper-3.4.6/conf/
ADD zookeeper-env.sh /opt/zookeeper-3.4.6/conf/
ADD start.sh /opt/zookeeper-3.4.6/

EXPOSE 2181 2888 3888
WORKDIR /opt/zookeeper-3.4.6

VOLUME ["/data"]
ENTRYPOINT ["/opt/zookeeper-3.4.6/start.sh"]



