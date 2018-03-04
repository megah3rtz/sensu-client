### Sensu-client docker contianer.
## This is ideally a minimal-ish docker container.

All cofiguration values are passed as environment variables. eg.

```
docker run -dit -e "SENSU_SERVER=127.0.0.1" -e "SENSU_USER=sensu" -e "SENSU_PASSWORD=password" -e "CLIENT_IP_ADDRESS=127.0.0.1" -e "CLIENT_NAME=wibble" sensu-server:latest
```
