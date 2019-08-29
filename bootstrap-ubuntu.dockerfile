# Stage 1. Build the bootstrap file.
FROM registry.gitlab.com/jitesoft/dockerfiles/ubuntu:bionic as pre-build
ENV CGO_ENABLED=0 \
    GOOS="linux" \
    GOARCH="amd64"

COPY ./go1.4-bootstrap-20171003.tar.gz /tmp/bootstrap.tar.gz

RUN apt-get update \
 && apt-get install -y gcc openssl tar ca-certificates \
 && tar -C /tmp -zxf /tmp/bootstrap.tar.gz \
 && mv /tmp/go /usr/local/bootstrap \
 && cd /usr/local/bootstrap/src \
 && chmod +x make.bash \
 && ./make.bash

# Stage 2. Copy bootstrap exec to the actual bootstrap image.
FROM registry.gitlab.com/jitesoft/dockerfiles/ubuntu:bionic
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
    GOROOT_BOOTSTRAP="/usr/local/bootstrap" \
    PATH="/usr/local/bootstrap/bin:$PATH"
COPY --from=pre-build  /usr/local/bootstrap /usr/local/bootstrap
