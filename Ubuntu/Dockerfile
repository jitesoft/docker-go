# syntax = docker/dockerfile:experimental
FROM registry.gitlab.com/jitesoft/dockerfiles/ubuntu:jammy
ARG VERSION
ARG BUILD_TIME

LABEL maintainer="Johannes Tegnér <johannes@jitesoft.com>" \
      maintainer.org="Jitesoft" \
      maintainer.org.uri="https://jitesoft.com" \
      com.jitesoft.project.repo.type="git" \
      com.jitesoft.project.repo.uri="https://gitlab.com/jitesoft/dockerfiles/go" \
      com.jitesoft.project.repo.issues="https://gitlab.com/jitesoft/dockerfiles/go/issues" \
      com.jitesoft.project.registry.uri="registry.gitlab.com/jitesoft/dockerfiles/go/ubuntu" \
      com.jitesoft.app.go.version="${VERSION}" \
      # Open container labels
      org.opencontainers.image.version="${VERSION}" \
      org.opencontainers.image.created="${BUILD_TIME}" \
      org.opencontainers.image.description="Go on Ubuntu linux" \
      org.opencontainers.image.vendor="Jitesoft" \
      org.opencontainers.image.source="https://gitlab.com/jitesoft/dockerfiles/go" \
      # Artifact hub annotations
      io.artifacthub.package.alternative-locations="oci://registry.gitlab.com/jitesoft/dockerfiles/go/ubuntu,oci://index.docker.io/jitesoft/go,oci://ghcr.io/jitesoft/go" \
      io.artifacthub.package.readme-url="https://gitlab.com/jitesoft/dockerfiles/go/-/raw/master/README.md" \
      io.artifacthub.package.logo-url="https://jitesoft.com/favicon-96x96.png"

ARG TARGETARCH
ENV PATH="/usr/local/go/bin:$PATH" \
    GOPATH="/go" \
    GOOS="linux" \
    GOARCH="${TARGETARCH}"

RUN --mount=type=bind,source=./bin,target=/tmp/bin \
    tar -xzhf /tmp/bin/go-${GOARCH}.tar.gz -C /usr/local/ \
 && apt-get update \
 && apt-get install -y git openssl ca-certificates \
 && mkdir -p "${GOPATH}/src" "${GOPATH}/bin" \
 && chmod -R 774 ${GOPATH} \
 && apt-get clean \
 && go version

WORKDIR /go
