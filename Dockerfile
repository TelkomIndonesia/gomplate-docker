ARG FSNOTIFY_VERSION=1.6.0
FROM hairyhenderson/gomplate:v${GOMPLATE_VERSION}-alpine AS gomplate
RUN apk add watchexec --repository=https://dl-cdn.alpinelinux.org/alpine/edge/testing
COPY entrypoint.sh /entrypoint.sh 
WORKDIR /opt/gomplate
ENTRYPOINT ["/entrypoint.sh"]