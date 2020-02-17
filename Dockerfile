# syntax = docker/dockerfile:experimental
ARG IMAGE
FROM registry.gitlab.com/jitesoft/dockerfiles/${IMAGE}
LABEL maintainer="Johannes Tegnér <johannes@jitesoft.com>" \
      maintainer.org="Jitesoft" \
      maintainer.org.uri="https://jitesoft.com" \
      com.jitesoft.project.repo.type="git" \
      com.jitesoft.project.repo.uri="https://gitlab.com/jitesoft/dockerfiles/go" \
      com.jitesoft.project.repo.issues="https://gitlab.com/jitesoft/dockerfiles/go/issues" \
      com.jitesoft.project.registry.uri="registry.gitlab.com/jitesoft/dockerfiles/go/bootstrap" \
      com.jitesoft.app.go.version="bootstrap"

ARG TARGETARCH
ENV CGO_ENABLED=0 \
    GOOS="linux" \
    GOARCH="${TARGETARCH}" \
    GOROOT_BOOTSTRAP="/usr/local/bootstrap" \
    PATH="/usr/local/bootstrap/bin:$PATH"

RUN mkdir /usr/local/bootstrap \
 && --mount=type=bind,source=/bin,target=/tmp/bin \
    tar -xhjf /tmp/bin/bootstrap-${GOARCH}.tbz -C /usr/local/bootstrap --strip-components=1
