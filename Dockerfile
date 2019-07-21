FROM alpine:3.10
LABEL maintainer="grokon"
LABEL application="squid-proxy"
HEALTHCHECK --interval=3s --retries=20 CMD nc -z localhost 3177
# add env
ENV SQUID_CONFIG_FILE /etc/squid/squid.conf
# install squid 4.8.r0
RUN apk add --no-cache squid
# add conf
RUN echo 'include /etc/squid/conf.d/*.conf' >> "$SQUID_CONFIG_FILE" && \
	install -d -m 755 -o squid -g squid /etc/squid/conf.d
COPY squid-log.conf /etc/squid/conf.d/
# add entrypoint
COPY entrypoint.sh /usr/local/bin/docker-entrypoint.sh
EXPOSE 3128/tcp
VOLUME ["/var/cache/squid"]
USER squid
ENTRYPOINT ["docker-entrypoint.sh"]
# -N Don't run in daemon mode - important for docker
# if need Debug add -X for verbose debug logging
CMD ["squid","-f","$SQUID_CONFIG_FILE","-NYCd","1","$EXTRA_ARGS"]
