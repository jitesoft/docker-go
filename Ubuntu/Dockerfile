# syntax = docker/dockerfile:experimental
FROM --platform=$BUILDPLATFORM registry.gitlab.com/jitesoft/dockerfiles/ubuntu:bionic AS stage0-bootstrap
ARG TARGETPLATFORM
ENV CGO_ENABLED=0 \
    GOOS="linux" \
    GOARCH="amd64"

COPY ./go1.4-bootstrap-20171003.tar.gz /tmp/bootstrap.tar.gz

RUN apt-get update \
 && apt-get install -y gcc openssl tar ca-certificates \
 && tar -C /tmp -zxf /tmp/bootstrap.tar.gz \
 && mv /tmp/go /usr/local/bootstrap \
 && cd /usr/local/bootstrap/src \
 && chmod +x make.bash \
 && taskset 1 ./make.bash

COPY ./go1.7.4.src.tar.gz /tmp/go.tar.gz

ENV GOROOT_BOOTSTRAP="/usr/local/bootstrap"

RUN mdkir /usr/local/bootstrap2 \
 && tar -C /usr/local/bootstrap2 -xzf /tmp/go.tar.gz \
 && cd /usr/local/bootstrap2/go/src \
 && ./bootstrap.bash

ENV GOROOT_BOOTSTRAP="/usr/local/bootstrap2/go"

RUN tar -C /usr/local -xzf /tmp/go.tar.gz \
 && cd /usr/local/go/src \
 && GOARCH=${TARGETPLATFORM} ./bootstrap.bash

####################

FROM registry.gitlab.com/jitesoft/dockerfiles/ubuntu:bionic
LABEL maintainer="Johannes Tegnér <johannes@jitesoft.com>" \
      maintainer.org="Jitesoft" \
      maintainer.org.uri="https://jitesoft.com" \
      com.jitesoft.project.repo.type="git" \
      com.jitesoft.project.repo.uri="https://gitlab.com/jitesoft/dockerfiles/go" \
      com.jitesoft.project.repo.issues="https://gitlab.com/jitesoft/dockerfiles/go/issues" \
      com.jitesoft.project.registry.uri="registry.gitlab.com/jitesoft/dockerfiles/go" \
      com.jitesoft.app.go.version="bootstrap"

ENV CGO_ENABLED=0 \
    GOOS="linux" \
    GOARCH="${TARGETPLATFORM}" \
    GOROOT_BOOTSTRAP="/usr/local/bootstrap" \
    PATH="/usr/local/bootstrap/bin:$PATH"

COPY --from=stage0-bootstrap  /usr/local/go /usr/local/bootstrap
