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
# Redefine version inside the build context.
ARG VERSION

ENV PATH="/usr/local/go/bin:$PATH" \
    GOPATH="/go"

COPY ./go${VERSION}.src.tar.xz /tmp/go.tar.xz
RUN apk add --no-cache ca-certificates \
 && [ ! -e /etc/nsswitch.conf ] && echo 'hosts: files dns' > /etc/nsswitch.conf \
 && apk add --no-cache --virtual .build bash gcc musl-dev openssl \
 && tar -C /usr/local -xzf /tmp/go.tar.xz \
 && rm -f /tmp/go.tar.xz \
 && cd /usr/local/go/src \
 && ./make.bash \
 && rm -rf /usr/local/go/pkg/bootstrap /usr/local/go/pkg/obj \
 && apk del .build \
 && go version \
 && mkdir -p "${GOPATH}/src" "${GOPATH}/bin" \
 && chmod -R 777 ${GOPATH}

WORKDIR /go