FROM golang:bookworm
ENV DEBIAN_FRONTEND noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y sudo apt-transport-https curl gnupg2 ca-certificates git

# Dependencies required to run inside of a Container
RUN apt-get update && \
    apt-get install -y gettext-base

# Build the openITCOCKPIT Monitoring Agent from source
WORKDIR /go/src
RUN git clone https://github.com/it-novum/openitcockpit-agent-go.git &&\
    cd openitcockpit-agent-go &&\
    go build -o openitcockpit-agent main.go &&\
    cp openitcockpit-agent /usr/bin/openitcockpit-agent &&\
    mkdir -p /var/log/openitcockpit-agent

COPY run.sh /run.sh
COPY config.ini.tpl /tmp/config.ini.tpl

RUN chmod +x /run.sh

ENV DOLLAR='$'

#
# Pull Mode related settings
#
ENV OITC_AGENT_PULL_BIND_ADDRESS=0.0.0.0
ENV OITC_AGENT_PULL_BIND_PORT=3333
ENV OITC_AGENT_PULL_AUTO_TLS=True

ENV OITC_AGENT_CONFIG_UPDATE_MODE=False

#
# Check related settings
#
ENV OITC_AGENT_CHECKS_INTERVAL=30
ENV OITC_AGENT_CUSTOMCHECKS_INI_FILE_PATH=/tmp/customchecks.ini
ENV OITC_AGENT_CHECKS_CPUSTATS=True
ENV OITC_AGENT_CHECKS_MEMORY=True
ENV OITC_AGENT_CHECKS_SWAP=True
ENV OITC_AGENT_CHECKS_PROCESSSTATS=True
ENV OITC_AGENT_CHECKS_NETSTATS=True
ENV OITC_AGENT_CHECKS_NETIO=True
ENV OITC_AGENT_CHECKS_DISKSTATS=True
ENV OITC_AGENT_CHECKS_DISKIO=True
# Most containers do not have any systemd at all
ENV OITC_AGENT_CHECKS_SYSTEMDSERVICES=False
# launchd is the init system of MacOS
ENV OITC_AGENT_CHECKS_LAUNCHDSERVICES=False
# Disable all Windows related checks
ENV OITC_AGENT_CHECKS_WINSERVICES=False
ENV OITC_AGENT_CHECKS_WINEVENTLOG=False
ENV OITC_AGENT_CHECKS_SENSORSTATS=False
# You can use this container to monitor other docker containers by passing the docker.sock
ENV OITC_AGENT_CHECKS_DOCKERSTATS=False
ENV OITC_AGENT_CHECKS_LIBVIRT=False
# This check will mostly fail when executed in a container
ENV OITC_AGENT_CHECKS_USERSTATS=False

#
# Push Mode related settings
#
ENV OITC_AGENT_PUSH_ENABLED=True
ENV OITC_AGENT_PUSH_ENABLE_WEBSERVER=False
ENV OITC_AGENT_PUSH_URL=""
ENV OITC_AGENT_PUSH_VERIFY_SERVER_CERTIFICATE=False
ENV OITC_AGENT_PUSH_TIMEOUT=10
ENV OITC_AGENT_PUSH_APIKEY=""
ENV OITC_AGENT_PUSH_HTTP_PROXY=""


CMD [ "/run.sh" ]
