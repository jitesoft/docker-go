# syntax = docker/dockerfile:experimental
FROM --platform=$BUILDPLATFORM registry.gitlab.com/jitesoft/dockerfiles/alpine:latest AS stage0-bootstrap
ARG TARGETPLATFORM
ENV CGO_ENABLED=0 \
    GOOS="linux" \
    GOARCH="amd64" \
    GOROOT_BOOTSTRAP="/usr/local/bootstrap"

COPY ./go1.4-bootstrap-20171003.tar.gz /tmp/bootstrap.tar.gz
COPY ./go1.11.src.tar.gz /tmp/go.tar.gz


RUN apk add --no-cache bash gcc musl-dev openssl tar ca-certificates \
 && tar -C /tmp -zxf /tmp/bootstrap.tar.gz \
 && mv /tmp/go /usr/local/bootstrap \
 && cd /usr/local/bootstrap/src \
 && chmod +x make.bash \
 && ./make.bash \
 && tar -C /usr/local -xzf /tmp/go.tar.gz \
 && cd /usr/local/go/src \
 && chmod +x make.bash \
 && ./make.bash --no-clean

RUN GOROOT_BOOTSTRAP="/usr/local/go" \
 && PATH="/usr/local/go/bin:$PATH" \
 && GOARCH="${TARGETPLATFORM##*/}" \
 && cd /usr/local/go/src \
 && chmod +x bootstrap.bash \
 && ./bootstrap.bash

RUN mkdir -p "/tmp/${TARGETPLATFORM}" \
 && mv "/usr/local/go-linux-${TARGETPLATFORM##*/}-bootstrap.tbz" "/tmp/${TARGETPLATFORM}/go.tbz"

FROM registry.gitlab.com/jitesoft/dockerfiles/alpine:latest
LABEL maintainer="Johannes Tegnér <johannes@jitesoft.com>" \
      maintainer.org="Jitesoft" \
      maintainer.org.uri="https://jitesoft.com" \
      com.jitesoft.project.repo.type="git" \
      com.jitesoft.project.repo.uri="https://gitlab.com/jitesoft/dockerfiles/go" \
      com.jitesoft.project.repo.issues="https://gitlab.com/jitesoft/dockerfiles/go/issues" \
      com.jitesoft.project.registry.uri="registry.gitlab.com/jitesoft/dockerfiles/go/bootstrap" \
      com.jitesoft.app.go.version="bootstrap"

ARG TARGETPLATFORM
ARG TARGETARCH
ENV CGO_ENABLED=0 \
    GOOS="linux" \
    GOARCH="${TARGETARCH}" \
    GOROOT_BOOTSTRAP="/usr/local/bootstrap" \
    PATH="/usr/local/bootstrap/bin:$PATH"

COPY --from=stage0-bootstrap /tmp/${TARGETPLATFORM} /tmp
RUN apk add --no-cache ca-certificates \
 && mkdir /usr/local/bootstrap \
 && tar -xjf /tmp/go.tbz -C /usr/local/bootstrap --strip-components=1 \
 && rm -rf /tmp/*







