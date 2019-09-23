# syntax = docker/dockerfile:experimental
FROM --platform=$BUILDPLATFORM registry.gitlab.com/jitesoft/dockerfiles/go:bootstrap AS bootstrap-chain
ARG VERSION
ARG TARGETPLATFORM
ENV GOARCH="${TARGETPLATFORM}"

COPY ./go${VERSION}.src.tar.gz /tmp/go.tar.gz

RUN apk add --no-cache --virtual .build bash gcc musl-dev openssl ca-certificates \
 && tar -C /usr/local -xzf /tmp/go.tar.gz \
 && rm -f /tmp/go.tar.gz \
 && cd /usr/local/go/src \
 && ./bootstrap.bash


FROM registry.gitlab.com/jitesoft/dockerfiles/alpine AS build
ARG VERSION
ARG TARGETPLATFORM
ARG BUILDPLATFORM
ENV GOARCH="${TARGETPLATFORM}" \
    CGO_ENABLED=0 \
    GOOS="linux" \
    GOROOT_BOOTSTRAP="/usr/local/bootstrap" \
    PATH="/usr/local/bootstrap/bin:$PATH"

COPY ./go${VERSION}.src.tar.gz /tmp/go.tar.gz
COPY --from=bootstrap-chain /usr/local/bootstrap /usr/local/bootstrap

RUN apk add --no-cache --virtual .build bash gcc musl-dev openssl ca-certificates \
 && tar -C /usr/local -xzf /tmp/go.tar.gz \
 && rm -f /tmp/go.tar.gz \
 && cd /usr/local/go/src \
 && ./make.bash \
 && rm -rf /usr/local/go/pkg/bootstrap /usr/local/go/pkg/obj


FROM registry.gitlab.com/jitesoft/dockerfiles/alpine:latest
ARG VERSION
LABEL maintainer="Johannes Tegnér <johannes@jitesoft.com>" \
      maintainer.org="Jitesoft" \
      maintainer.org.uri="https://jitesoft.com" \
      com.jitesoft.project.repo.type="git" \
      com.jitesoft.project.repo.uri="https://gitlab.com/jitesoft/dockerfiles/go" \
      com.jitesoft.project.repo.issues="https://gitlab.com/jitesoft/dockerfiles/go/issues" \
      com.jitesoft.project.registry.uri="registry.gitlab.com/jitesoft/dockerfiles/go" \
      com.jitesoft.app.go.version="${VERSION}"

ARG TARGETPLATFORM
ENV PATH="/usr/local/go/bin:$PATH" \
    GOPATH="/go" \
    GOOS="linux" \
    GOARCH="${TARGETPLATFORM}"

COPY --from=build /usr/local/go /usr/local/go

RUN mkdir -p "${GOPATH}/src" "${GOPATH}/bin" \
 && chmod -R 777 ${GOPATH} \
 && [ ! -e /etc/nsswitch.conf ] && echo 'hosts: files dns' > /etc/nsswitch.conf \
 && go version

WORKDIR /go
