FROM debian:latest

RUN apt-get update && apt-get install wget gnupg apt-transport-https -y
RUN wget -q https://sensu.global.ssl.fastly.net/apt/pubkey.gpg -O- | apt-key add -
RUN echo "deb     https://sensu.global.ssl.fastly.net/apt stretch main" | tee /etc/apt/sources.list.d/sensu.list
RUN echo "Installing Sensu plugins"
RUN apt-get update && apt-get install sensu ruby ruby-dev make gcc build-essential -y \
&& /opt/sensu/embedded/bin/gem install sensu-plugins-disk-checks \
&& /opt/sensu/embedded/bin/gem install sensu-plugins-memory-checks \
&& /opt/sensu/embedded/bin/gem install sensu-plugins-load-checks \
&& /opt/sensu/embedded/bin/gem install sensu-plugins-disk-checks \
&& /opt/sensu/embedded/bin/gem install sensu-plugins-cpu-checks \
&& /opt/sensu/embedded/bin/gem install sensu-plugins-http

# PEM files are from https://github.com/hiroakis/docker-sensu-server - THESE ARE NOT SECURE!
ADD key.pem /etc/sensu/ssl/key.pem
ADD cert.pem /etc/sensu/ssl/cert.pem
# PEM files are from https://github.com/hiroakis/docker-sensu-server - THESE ARE NOT SECURE!
ADD supervisor.conf /etc/supervisord.conf
ADD config.json /tmp/config.json
ADD client.json /tmp/client.json
ADD check_disk.json /tmp/check_disk.json


ADD run-sensu-client.sh /opt/run-sensu-client.sh
RUN chmod 700 /opt/run-sensu-client.sh

ENTRYPOINT ["/opt/run-sensu-client.sh"]
