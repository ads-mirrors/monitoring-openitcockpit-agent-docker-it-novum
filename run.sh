#!/bin/bash

# Create openITCOCKPIT Monitoring Agent Config File from ENV
envsubst < /tmp/config.ini.tpl > /tmp/config.ini

/usr/bin/openitcockpit-agent --config /tmp/config.ini --log /var/log/openitcockpit-agent/agent.log