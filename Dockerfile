FROM registry.gitlab.com/jitesoft/dockerfiles/go:bootstrap as build
ARG VERSION

ENV PATH="/usr/local/bootstrap/bin:$PATH" \
    GOROOT_BOOTSTRAP=""

COPY ./go${VERSION}.src.tar.gz /tmp/go.tar.gz
RUN apk add --no-cache --virtual .build bash gcc musl-dev openssl \
 && tar -C /usr/local -xzf /tmp/go.tar.gz \
 && rm -f /tmp/go.tar.gz \
 && cd /usr/local/go/src \
 && ./all.bash \
 && rm -rf /usr/local/go/pkg/bootstrap /usr/local/go/pkg/obj \
 && apk del .build \
 && go version

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
    GOPATH="/go" \
    GOOS="linux" \
    GOARCH="amd64"

COPY --from=build ./go${VERSION}.src.tar.gz /tmp/go.tar.gz

RUN apk add --no-cache ca-certificates \
 && [ ! -e /etc/nsswitch.conf ] && echo 'hosts: files dns' > /etc/nsswitch.conf \
 && tar -C /usr/local -xzf /tmp/go.tar.gz \
 && rm -f /tmp/go.tar.gz \
 && cd /usr/local/go/src \
 && ./make.bash \
 && rm -rf /usr/local/go/pkg/bootstrap /usr/local/go/pkg/obj \
 && apk del .build \

 && mkdir -p "${GOPATH}/src" "${GOPATH}/bin" \
 && chmod -R 777 ${GOPATH} \
 && go version \

WORKDIR /go



 && mkdir -p "${GOPATH}/src" "${GOPATH}/bin" \
 && chmod -R 777 ${GOPATH}
