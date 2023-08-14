[default]
#
# This is the configuration file for the openITCOCKPIT Monitoring Agent 3.x
# Notice: Empty values will not been ignored! If you want to disable an option like proxy comment it out!

#########################
#       Web Server      #
#########################

# Bind address of the build-in web server
# Use 0.0.0.0 to bind on all interfaces
address = $OITC_AGENT_PULL_BIND_ADDRESS

# Port of the Agents build-in web server
# Default port is 3333
port = $OITC_AGENT_PULL_BIND_PORT

#########################
#   Security Settings   #
#########################

# Try to enable auto ssl mode for webserver
try-autossl = $OITC_AGENT_PULL_AUTO_TLS

# File paths used to store autossl related files (default: /etc/openitcockpit-agent/):
# Leave this blank to use the default values
# Example: /etc/openitcockpit-agent/agent.csr
#autossl-csr-file =

# Example: /etc/openitcockpit-agent/agent.crt
#autossl-crt-file =

# Example: /etc/openitcockpit-agent/agent.key
#autossl-key-file =

# Example: /etc/openitcockpit-agent/server_ca.crt
#autossl-ca-file =

# If a certificate file is given, the agent will only be accessible through HTTPS
# Instead of messing around with self-signed certificates we recommend to use the autossl feature.
# Example: /etc/ssl/certs/ssl-cert-snakeoil.pem
#certfile = /etc/ssl/certs/ssl-cert-snakeoil.pem

# Private key file of the given TLS certificate
# Example: /etc/ssl/private/ssl-cert-snakeoil.key
#keyfile = /etc/ssl/private/ssl-cert-snakeoil.key

# Enable remote read and write access to the current agent configuration (this file) and
# the customchecks config
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# ! WARNING: This could lead to remote code execution    !
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
config-update-mode = $OITC_AGENT_CONFIG_UPDATE_MODE

# Enable HTTP Basic Authentication
# Disabled if blank
# Example: auth = user:password
#auth = user:password

#########################
#        Checks         #
#########################

# Determines in seconds how often the agent will schedule all internal checks
interval = $OITC_AGENT_CHECKS_INTERVAL

# Remote Plugin Execution
# Path to config will where custom checks can be defined
# Leave blank for the default value
#
# Linux: /etc/openitcockpit-agent/customchecks.ini
# Windows: C:\Program Files\it-novum\openitcockpit-agent\customchecks.ini
# macOS: /Applications/openitcockpit-agent/customchecks.ini
customchecks = $OITC_AGENT_CUSTOMCHECKS_INI_FILE_PATH

#########################
# Enable/Disable checks #
#########################

# Enable CPU monitoring
cpustats = $OITC_AGENT_CHECKS_CPUSTATS

# Enable memory monitoring
memory = $OITC_AGENT_CHECKS_MEMORY

# Enable Swap monitoring
swap = $OITC_AGENT_CHECKS_SWAP

# Enable monitoring of running processes
processstats = $OITC_AGENT_CHECKS_PROCESSSTATS

# Enable monitoring of network interfaces
netstats = $OITC_AGENT_CHECKS_NETSTATS

# Enable monitoring of the traffic (I/O) of network interfaces
netio = $OITC_AGENT_CHECKS_NETIO

# Enable disk usage monitoring
diskstats = $OITC_AGENT_CHECKS_DISKSTATS

# Enable monitoring of disk I/O
diskio = $OITC_AGENT_CHECKS_DISKIO

# Enable monitoring of Systemd Services (Linux only)
systemdservices = $OITC_AGENT_CHECKS_SYSTEMDSERVICES

# Enable monitoring of Launchd Services (macOS only)
launchdservices = $OITC_AGENT_CHECKS_LAUNCHDSERVICES

# Enable monitoring of Windows Services (Windows only)
winservices = $OITC_AGENT_CHECKS_WINSERVICES

# Enable monitoring of Windows Event Log records (Windows only)
wineventlog = $OITC_AGENT_CHECKS_WINEVENTLOG

# Determines how the openITCOCKPIT Monitoring Agent should query the Windows Event Log.
# Since Version 3.0.9 WMI (Windows Management Instrumentation) will be used by default
# As alternative the Agent could use the PowerShell Get-EventLog cmdlet.
# The WMI method will maybe memory leak on Windows Server 2016. The PowerShell workaround
# on the other hand could lead to blue screens (OA-40).
wineventlog-method = WMI
#wineventlog-method = PowerShell

# Define comma separated windows event log log types
# Event Logs containing spaces DO NOT need to be quoted: Security,Sophos Cloud AD Sync,Application
wineventlog-logtypes = System,Application,Security

# Define the age in seconds of the event log records
wineventlog-age = 3600

# Enable monitoring of temperature and battery sensors
sensorstats = $OITC_AGENT_CHECKS_SENSORSTATS

# Enable support to monitor Docker containers
# Known issues: Error response from daemon: client version 1.41 is too new. Maximum supported API version is 1.40
# Workaround: export DOCKER_API_VERSION=1.40
dockerstats = $OITC_AGENT_CHECKS_DOCKERSTATS

# Check KVMs through libvirt
# This requires to compile the openITCOCKPIT Monitoring Agent by yourself.
# Please see the Wiki for instructions: https://github.com/it-novum/openitcockpit-agent-go/wiki/Build-binary
libvirt = $OITC_AGENT_CHECKS_LIBVIRT

# Enable logged in users check
userstats = $OITC_AGENT_CHECKS_USERSTATS

#########################
#       Push mode       #
#########################

# By default openITCOCKPIT will pull check results from the openITCOCKPIT Agent.
# In a cloud environments or behind a NAT network it could become handy
# if the openITCOCKPIT Monitoring Agent will push the results to your openITCOCKPIT Server
[oitc]

# Enable Push Mode
enabled = $OITC_AGENT_PUSH_ENABLED

# This option disables the webserver of the openITCOCKPIT Monitoring Agent when running in PUSH mode.
# When you also want to enable the Webserver even if the agent is running in PUSH mode we highly recommend
# to enable HTTP Basic Authentication and to use the certfile and keyfile options to enable HTTPS
enable-webserver = $OITC_AGENT_PUSH_ENABLE_WEBSERVER

# Address of your openITCOCKPIT Server where the Agent will push the results to
# Example: https://demo.openitcockpit.io
url = $OITC_AGENT_PUSH_URL

# Enable this option when your openITCOCKPIT server uses valid TLS certificates
# like from Let's Encrypt
verify-server-certificate = $OITC_AGENT_PUSH_VERIFY_SERVER_CERTIFICATE

# Timeout in seconds for the HTTP push client
timeout = $OITC_AGENT_PUSH_TIMEOUT

# API-Key of your openITCOCKPIT Server
apikey = $OITC_AGENT_PUSH_APIKEY

# Address of HTTP/HTTPS Proxy if required.
# Leave blank to not use a proxy server
# Example: http://10.10.1.10:3128
proxy = $OITC_AGENT_PUSH_HTTP_PROXY
