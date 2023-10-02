ARG GOMPLATE_VERSION=3.11.5
FROM hairyhenderson/gomplate:v${GOMPLATE_VERSION}-alpine AS gomplate
RUN apk add watchexec --repository=https://dl-cdn.alpinelinux.org/alpine/edge/testing
COPY entrypoint.sh /entrypoint.sh 
WORKDIR /opt/gomplate
ENTRYPOINT ["/entrypoint.sh"]