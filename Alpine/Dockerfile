# syntax = docker/dockerfile:experimental
FROM --platform=$BUILDPLATFORM registry.gitlab.com/jitesoft/dockerfiles/alpine:latest AS stage0-bootstrap
ENV CGO_ENABLED=0 \
    GOOS="linux" \
    GOARCH="amd64"

COPY ./go1.4-bootstrap-20171003.tar.gz /tmp/bootstrap.tar.gz

RUN apk add --no-cache bash gcc musl-dev openssl tar ca-certificates \
 && tar -C /tmp -zxf /tmp/bootstrap.tar.gz \
 && mv /tmp/go /usr/local/bootstrap \
 && cd /usr/local/bootstrap/src \
 && chmod +x make.bash \
 && ./make.bash

COPY ./go1.7.4.src.tar.gz /tmp/go.tar.gz

RUN tar -C /usr/local -xzf /tmp/go.tar.gz \
 && cd /usr/local/go/src \
 && GOOS=linux GOARCH=${TARGETPLATFORM##*/} ./bootstrap.bash

####################

FROM registry.gitlab.com/jitesoft/dockerfiles/alpine:latest
LABEL maintainer="Johannes Tegnér <johannes@jitesoft.com>" \
      maintainer.org="Jitesoft" \
      maintainer.org.uri="https://jitesoft.com" \
      com.jitesoft.project.repo.type="git" \
      com.jitesoft.project.repo.uri="https://gitlab.com/jitesoft/dockerfiles/go" \
      com.jitesoft.project.repo.issues="https://gitlab.com/jitesoft/dockerfiles/go/issues" \
      com.jitesoft.project.registry.uri="registry.gitlab.com/jitesoft/dockerfiles/go" \
      com.jitesoft.app.go.version="bootstrap"

ARG TARGETPLATFORM
ENV CGO_ENABLED=0 \
    GOOS="linux" \
    GOARCH="${TARGETPLATFORM}" \
    GOROOT_BOOTSTRAP="/usr/local/bootstrap" \
    PATH="/usr/local/bootstrap/bin:$PATH"

RUN apk add --no-cache ca-certificates
COPY --from=stage0-bootstrap  /usr/local/go /usr/local/bootstrap








