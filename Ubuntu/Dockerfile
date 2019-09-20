# syntax=docker/dockerfile:experimental
FROM $BUILDPLATFORM registry.gitlab.com/jitesoft/dockerfiles/go/ubuntu:bootstrap as bootstrap-chain
ARG VERSION
ARG TARGETPLATFORM
ENV GOARCH="${TARGETPLATFORM}"

COPY ./go${VERSION}.src.tar.gz /tmp/go.tar.gz

RUN export GOARCH="${TARGETPLATFORM##*/}" \
 && apt-get update \
 && apt-get install -y gcc openssl ca-certificates \
 && tar -C /usr/local -xzf /tmp/go.tar.gz \
 && rm -f /tmp/go.tar.gz \
 && cd /usr/local/go/src \
 && ./bootstrap.bash

FROM registry.gitlab.com/jitesoft/dockerfiles/go/ubuntu as build
ARG VERSION
ARG TARGETPLATFORM

COPY --from=bootstrap-chain /usr/local/bootstrap /usr/local/bootstrap
COPY ./go${VERSION}.src.tar.gz /tmp/go.tar.gz

ARG TARGETPLATFORM
RUN export GOARCH="${TARGETPLATFORM##*/}" \
 && apt-get update \
 && apt-get install -y gcc openssl ca-certificates \
 && tar -C /usr/local -xzf /tmp/go.tar.gz \
 && rm -f /tmp/go.tar.gz \
 && cd /usr/local/go/src \
 && taskset 1 ./make.bash \
 && rm -rf /usr/local/go/pkg/bootstrap /usr/local/go/pkg/obj

FROM registry.gitlab.com/jitesoft/dockerfiles/ubuntu:bionic
ARG VERSION
LABEL maintainer="Johannes Tegnér <johannes@jitesoft.com>" \
      maintainer.org="Jitesoft" \
      maintainer.org.uri="https://jitesoft.com" \
      com.jitesoft.project.repo.type="git" \
      com.jitesoft.project.repo.uri="https://gitlab.com/jitesoft/dockerfiles/go" \
      com.jitesoft.project.repo.issues="https://gitlab.com/jitesoft/dockerfiles/go/issues" \
      com.jitesoft.project.registry.uri="registry.gitlab.com/jitesoft/dockerfiles/go/ubuntu" \
      com.jitesoft.app.go.version="${VERSION}"

ARG TARGETPLATFORM
ENV PATH="/usr/local/go/bin:$PATH" \
    GOPATH="/go" \
    GOOS="linux" \
    GOARCH="${TARGETPLATFORM}"

COPY --from=build /usr/local/go /usr/local/go

RUN  mkdir -p "${GOPATH}/src" "${GOPATH}/bin" \
 && chmod -R 777 ${GOPATH} \
 && go version

WORKDIR /go
