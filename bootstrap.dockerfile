# Stage 1. Build the bootstrap file.
FROM registry.gitlab.com/jitesoft/dockerfiles/alpine:latest
ENV CGO_ENABLED=0 \
    GOOS="linux" \
    GOARCH="amd64"

COPY ./go1.4-bootstrap-20171003.tar.gz /tmp/bootstrap.tar.gz

RUN apk add --no-cache bash gcc musl-dev openssl tar ca-certificates \
 && tar -C /tmp -zxf /tmp/bootstrap.tar.gz \
 && cd /tmp/go/src \
 && chmod +x make.bash
 && ./make.bash

# Stage 2. Copy bootstrap exec to the actual bootstrap image.
FROM registry.gitlab.com/jitesoft/dockerfiles/alpine:latest
LABEL maintainer="Johannes Tegnér <johannes@jitesoft.com>" \
      maintainer.org="Jitesoft" \
      maintainer.org.uri="https://jitesoft.com" \
      com.jitesoft.project.repo.type="git" \
      com.jitesoft.project.repo.uri="https://gitlab.com/jitesoft/dockerfiles/go" \
      com.jitesoft.project.repo.issues="https://gitlab.com/jitesoft/dockerfiles/go/issues" \
      com.jitesoft.project.registry.uri="registry.gitlab.com/jitesoft/dockerfiles/go" \
      com.jitesoft.app.go.version="1.4-bootstrap"

ENV CGO_ENABLED=0 \
    GOOS="linux" \
    GOARCH="amd64" \
    GOROOT_BOOTSTRAP="/usr/local/bootstrap"

RUN apk add --no-cache ca-certificates \
 && mkdir -p /usr/local/bootstrap

COPY --from=0  /tmp/go/go-${GOOS}-${GOARCH}-bootstrap /usr/local/bootstrap
