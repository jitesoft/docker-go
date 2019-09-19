# Stage 1. Build the bootstrap file.
FROM registry.gitlab.com/jitesoft/dockerfiles/alpine:latest as pre-build
ARG TARGETPLATFORM
ENV CGO_ENABLED=0 \
    GOOS="linux"

COPY ./go1.4-bootstrap-20171003.tar.gz /tmp/bootstrap.tar.gz

RUN export GOARCH="${TARGETPLATFORM##*/}" \
 && apk add --no-cache bash gcc musl-dev openssl tar ca-certificates \
 && tar -C /tmp -zxf /tmp/bootstrap.tar.gz \
 && mv /tmp/go /usr/local/bootstrap \
 && cd /usr/local/bootstrap/src \
 && chmod +x make.bash \
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
ARG TARGETPLATFORM
ENV CGO_ENABLED=0 \
    GOOS="linux" \
    GOROOT_BOOTSTRAP="/usr/local/bootstrap" \
    PATH="/usr/local/bootstrap/bin:$PATH"

RUN apk add --no-cache ca-certificates
COPY --from=pre-build  /usr/local/bootstrap /usr/local/bootstrap