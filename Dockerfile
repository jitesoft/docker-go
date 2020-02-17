# syntax = docker/dockerfile:experimental
ARG IMAGE
ARG TAG
FROM registry.gitlab.com/jitesoft/dockerfiles/${IMAGE}:${TAG}
LABEL maintainer="Johannes Tegnér <johannes@jitesoft.com>" \
      maintainer.org="Jitesoft" \
      maintainer.org.uri="https://jitesoft.com" \
      com.jitesoft.project.repo.type="git" \
      com.jitesoft.project.repo.uri="https://gitlab.com/jitesoft/dockerfiles/go" \
      com.jitesoft.project.repo.issues="https://gitlab.com/jitesoft/dockerfiles/go/issues" \
      com.jitesoft.project.registry.uri="registry.gitlab.com/jitesoft/dockerfiles/go/bootstrap" \
      com.jitesoft.app.go.version="bootstrap"

ARG TARGETARCH
ARG IMAGE
ENV CGO_ENABLED=0 \
    GOOS="linux" \
    GOARCH="${TARGETARCH}" \
    GOROOT_BOOTSTRAP="/usr/local/bootstrap" \
    PATH="/usr/local/bootstrap/bin:$PATH"

RUN if [ "${IMAGE}" = "debian" ]; then apt-get install bzip2; fi \
 && mkdir /usr/local/bootstrap \
 && --mount=type=bind,source=/bin,target=/tmp/bin \
    tar -xhjf /tmp/bin/bootstrap-${GOARCH}.tbz -C /usr/local/bootstrap --strip-components=1
