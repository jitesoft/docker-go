# syntax = docker/dockerfile:experimental
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

ARG TARGETARCH
ENV PATH="/usr/local/go/bin:$PATH" \
    GOPATH="/go" \
    GOOS="linux" \
    GOARCH="${TARGETARCH}"

RUN --mount=type=bind,source=./bin,target=/tmp/bin \
    tar -xzhf /tmp/bin/go-${GOARCH}.tar.gz -C /usr/local/go \
 && apt-get update \
 && apt-get install -y git openssl ca-certificates \
 && mkdir -p "${GOPATH}/src" "${GOPATH}/bin" \
 && chmod -R 774 ${GOPATH} \
 && apt-get clean \
 && go version

WORKDIR /go
