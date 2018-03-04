FROM centos:latest
ADD sensu.repo /etc/yum.repos.d/sensu.repo
RUN yum update -y
RUN yum install epel-release -y
RUN yum install sensu supervisor -y

ADD supervisor.conf /etc/supervisord.conf
ADD config.json /tmp/config.json
ADD client.json /tmp/client.json
ADD run-sensu-client.sh /opt/run-sensu-client.sh
RUN chmod 700 /opt/run-sensu-client.sh
ENTRYPOINT ["/opt/run-sensu-client.sh"]
