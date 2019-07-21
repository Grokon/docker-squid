# docker-squid

Docker Squid container based on Alpine Linux.

Automated builds of the image are available on [Dockerhub](https://hub.docker.com/r/grokon/squid).


# Quick Start

Just launch container:

```bash
docker run -p 3128:3128 --name docker-squid grokon/squid
```

or use [docker-compose](https://docs.docker.com/compose/):

```bash
wget https://raw.githubusercontent.com/grokon/docker-squid/master/docker-compose.yml
docker-compose up
```

# Configuration

## Environment variables:

- **SQUID_CONFIG_FILE**: Specify the configuration file for squid. Defaults to `/etc/squid/squid.conf`.

    ### Example:

    ```bash
    docker run -p 3128:3128 \
        --name docker-squid \
        grokon/squid
    ```

- **EXTRA_ARGS**: Add extra arguments for squid.

    * **DEBUG**: if need Debug add -X for verbose debug logging: EXTRA_ARGS: -X

        ### Example:

        ```bash
        docker run -p 3128:3128 \
            --env EXTRA_ARGS="-X" \
            --name docker-squid \
            grokon/squid
        ```


## Unit File for systemd

This is an example of a systemd unit file to persistly start docker-squid:

```
[Unit]
Description=Squid4 Docker Container
Documentation=http://wiki.squid.org
After=network.target docker.service
Requires=docker.service

[Service]
ExecStartPre=-/usr/bin/docker kill docker-squid
ExecStartPre=-/usr/bin/docker rm docker-squid
ExecStart=/usr/bin/docker run --net=host --rm \
    -v /srv/squid/cache:/var/cache/squid \
    --name docker-squid \
    squid

[Install]
WantedBy=multi-user.target
```

