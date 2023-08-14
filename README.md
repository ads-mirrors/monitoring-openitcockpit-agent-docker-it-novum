# openITCOCKPIT Monitoring Agent Docker Image
Run the openITCOCKPIT Monitoring Agent in a Docker Container

Source: https://github.com/it-novum/openitcockpit-agent-go


# Build the image
```
docker build . -t openitcockpit-agent:latest
```

# Run the openITCOCKPIT Monitoring Agent
By default, the openITCOCKPIT Monitoring Agent will operate in **Push Mode**. This fits best when running inside a Container.
This behavior can be changed if required.


First, create the volume that the openITCOCKPIT Monitoring Agent will use to store persistend data
```
docker volume create oitc_agent_data
```

Then, start the contianer
```
docker run -d --name oitc-agent --restart=always -e OITC_AGENT_PUSH_URL="https://demo.openitcockpit.io" -e OITC_AGENT_PUSH_APIKEY="eae64a10870399" -v oitc_agent_data:/etc/openitcockpit-agent openitcockpit-agent:latest
```

## Monitor other containers
To monitor other docker containers, you need to pass the `docker.sock`. It is also importat to enable the Docker checks by passing the environment variable `OITC_AGENT_CHECKS_DOCKERSTATS=True`
```
docker run -d --name oitc-agent --restart=always -e OITC_AGENT_PUSH_URL="https://demo.openitcockpit.io" -e OITC_AGENT_PUSH_APIKEY="eae64a10870399" -e OITC_AGENT_CHECKS_DOCKERSTATS=True -v oitc_agent_data:/etc/openitcockpit-agent -v /var/run/docker.sock:/var/run/docker.sock openitcockpit-agent:latest
```

## Operate in Pull Mode
It is also possible to run the openITCOCKPIT Monitoring Agent in Pull Mode.
```
docker run -d --name oitc-agent --restart=always -p 3333:3333 -e OITC_AGENT_PUSH_ENABLED=False -v oitc_agent_data:/etc/openitcockpit-agent openitcockpit-agent:latest
```


# Environment Variables

| Variable Name                             | Default Value           | Description                                                                         |
| ----------------------------------------- | ----------------------- | ----------------------------------------------------------------------------------- |
| OITC_AGENT_PULL_BIND_ADDRESS              | `0.0.0.0`               | Bind address of the build-in web server                                             |
| OITC_AGENT_PULL_BIND_PORT                 | `3333`                  | Port of the Agents build-in web server (**Required in Pull-Mode**)                  |
| OITC_AGENT_PULL_AUTO_TLS                  | `True`                  | Try to enable auto ssl mode for webserver                                           |
| OITC_AGENT_CONFIG_UPDATE_MODE             | `False`                 | Enable agent config update mode - WARNING: This could lead to remote code execution |
| OITC_AGENT_CHECKS_INTERVAL                | `30`                    | Determines in seconds how often the agent will schedule all internal checks         |
| OITC_AGENT_CUSTOMCHECKS_INI_FILE_PATH     | `/tmp/customchecks.ini` | Path to custom checks configuration file                                            |
| OITC_AGENT_CHECKS_CPUSTATS                | `True`                  | Enable CPU monitoring                                                               |
| OITC_AGENT_CHECKS_MEMORY                  | `True`                  | Enable memory monitoring                                                            |
| OITC_AGENT_CHECKS_SWAP                    | `True`                  | Enable swap statistics monitoring                                                   |
| OITC_AGENT_CHECKS_PROCESSSTATS            | `True`                  | Enable monitoring of running processes                                              |
| OITC_AGENT_CHECKS_NETSTATS                | `True`                  | Enable monitoring of network interfaces                                             |
| OITC_AGENT_CHECKS_NETIO                   | `True`                  | Enable network I/O monitoring                                                       |
| OITC_AGENT_CHECKS_DISKSTATS               | `True`                  | Enable disk usage monitoring                                                        |
| OITC_AGENT_CHECKS_DISKIO                  | `True`                  | Enable disk I/O monitoring                                                          |
| OITC_AGENT_CHECKS_SYSTEMDSERVICES         | `False`                 | Enable systemd services check (not supported in most containers)                    |
| OITC_AGENT_CHECKS_LAUNCHDSERVICES         | `False`                 | Enable launchd services check (macOS only)                                          |
| OITC_AGENT_CHECKS_WINSERVICES             | `False`                 | Enable Windows services check (not supported by this container)                     |
| OITC_AGENT_CHECKS_WINEVENTLOG             | `False`                 | Enable Windows event log check (not supported by this container)                    |
| OITC_AGENT_CHECKS_SENSORSTATS             | `False`                 | Enable sensor statistics check                                                      |
| OITC_AGENT_CHECKS_DOCKERSTATS             | `False`                 | Enable Docker container statistics check                                            |
| OITC_AGENT_CHECKS_LIBVIRT                 | `False`                 | Enable libvirt (virtualization) check (not supported by this container)             |
| OITC_AGENT_CHECKS_USERSTATS               | `False`                 | Enable user statistics check  (not supported in most containers)                    |
| OITC_AGENT_PUSH_ENABLED                   | `True`                  | Enable agent push mode                                                              |
| OITC_AGENT_PUSH_ENABLE_WEBSERVER          | `False`                 | Enable build-in web server when running in push mode                                |
| OITC_AGENT_PUSH_URL                       |                         | URL for agent push mode (**Required in Push-Mode**)                                 |
| OITC_AGENT_PUSH_VERIFY_SERVER_CERTIFICATE | `False`                 | Verify server certificate for agent push mode                                       |
| OITC_AGENT_PUSH_TIMEOUT                   | `10`                    | Timeout for agent push mode                                                         |
| OITC_AGENT_PUSH_APIKEY                    |                         | API-Key of your openITCOCKPIT Server  (**Required in Push-Mode**)                   |
| OITC_AGENT_PUSH_HTTP_PROXY                |                         | Address of HTTP/HTTPS Proxy if required. (e.g.: `http://10.10.1.10:3128` )          |
