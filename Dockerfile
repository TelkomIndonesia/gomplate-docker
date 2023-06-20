ARG FSNOTIFY_VERSION=1.6.0
ARG GOMPLATE_VERSION=3.11.5



FROM golang:1.20.4-bullseye AS fsnotify

ARG FSNOTIFY_VERSION
WORKDIR /src
RUN git clone https://github.com/fsnotify/fsnotify \
    && cd fsnotify \
    && git fetch --all --tags \
    && git checkout tags/v${FSNOTIFY_VERSION}

RUN cd fsnotify/cmd/fsnotify \
  && GOOS=linux go build -tags release -a -ldflags "-extldflags -static" -o fsnotify



FROM hairyhenderson/gomplate:v${GOMPLATE_VERSION}-alpine AS gomplate

COPY --from=fsnotify /src/fsnotify/cmd/fsnotify/fsnotify /bin/fsnotify