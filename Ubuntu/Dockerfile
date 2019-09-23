# syntax = docker/dockerfile:experimental
FROM --platform=$BUILDPLATFORM registry.gitlab.com/jitesoft/dockerfiles/ubuntu:bionic AS stage0-bootstrap
ARG TARGETPLATFORM
ENV CGO_ENABLED=0 \
    GOROOT_BOOTSTRAP="/usr/local/bootstrap" \
    GOOS="linux" \
    GOARCH="amd64"

COPY ./go1.4-bootstrap-20171003.tar.gz /tmp/bootstrap.tar.gz
COPY ./go1.7.4.src.tar.gz /tmp/go.tar.gz

RUN apt-get update \
 && apt-get install -y gcc openssl tar ca-certificates \
 && tar -C /tmp -zxf /tmp/bootstrap.tar.gz \
 && mv /tmp/go /usr/local/bootstrap \
 && cd /usr/local/bootstrap/src \
 && chmod +x make.bash \
 && ./make.bash \
 &&  && tar -C /usr/local -xzf /tmp/go.tar.gz \
 && cd /usr/local/go/src \
 && chmod +x make.bash \
 && ./make.bash

####################

FROM --platform=$BUILDPLATFORM registry.gitlab.com/jitesoft/dockerfiles/ubuntu:bionic AS stage1-bootstrap
ARG TARGETPLATFORM
ENV CGO_ENABLED=0 \
    GOOS="linux" \
    GOROOT_BOOTSTRAP="/usr/local/go" \
    PATH="/usr/local/bootstrap/bin:$PATH"

COPY ./go1.7.4.src.tar.gz /tmp/go.tar.gz
COPY --from=stage0-bootstrap  /usr/local/go /usr/local/bootstrap

RUN export GOARCH="${TARGETPLATFORM##*/}" \
 && tar -C /usr/local/ -xzf /tmp/go.tar.gz \
 && cd /usr/local/go \
 && GOARCH="${TARGETPLATFORM##*/}" \
 && chmod +x bootstrap.bash \
 && ./bootstrap.bash

####################

FROM registry.gitlab.com/jitesoft/dockerfiles/ubuntu:bionic
LABEL maintainer="Johannes Tegnér <johannes@jitesoft.com>" \
      maintainer.org="Jitesoft" \
      maintainer.org.uri="https://jitesoft.com" \
      com.jitesoft.project.repo.type="git" \
      com.jitesoft.project.repo.uri="https://gitlab.com/jitesoft/dockerfiles/go" \
      com.jitesoft.project.repo.issues="https://gitlab.com/jitesoft/dockerfiles/go/issues" \
      com.jitesoft.project.registry.uri="registry.gitlab.com/jitesoft/dockerfiles/go/bootstrap" \
      com.jitesoft.app.go.version="bootstrap"

ENV CGO_ENABLED=0 \
    GOOS="linux" \
    GOARCH="${TARGETPLATFORM}" \
    GOROOT_BOOTSTRAP="/usr/local/bootstrap" \
    PATH="/usr/local/bootstrap/bin:$PATH"

COPY --from=stage1-bootstrap  /usr/local/go /usr/local/bootstrap
