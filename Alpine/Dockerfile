FROM registry.gitlab.com/jitesoft/dockerfiles/go:bootstrap as build
ARG VERSION
ARG TARGETPLATFORM
ENV GOARCH="${TARGETPLATFORM}"

COPY ./go${VERSION}.src.tar.gz /tmp/go.tar.gz

RUN apk add --no-cache --virtual .build bash gcc musl-dev openssl ca-certificates \
 && tar -C /usr/local -xzf /tmp/go.tar.gz \
 && rm -f /tmp/go.tar.gz \
 && cd /usr/local/go/src \
 && ./make.bash \
 && rm -rf /usr/local/go/pkg/bootstrap /usr/local/go/pkg/obj \
 && apk del .build

FROM registry.gitlab.com/jitesoft/dockerfiles/alpine:latest
LABEL maintainer="Johannes Tegnér <johannes@jitesoft.com>" \
      maintainer.org="Jitesoft" \
      maintainer.org.uri="https://jitesoft.com" \
      com.jitesoft.project.repo.type="git" \
      com.jitesoft.project.repo.uri="https://gitlab.com/jitesoft/dockerfiles/go" \
      com.jitesoft.project.repo.issues="https://gitlab.com/jitesoft/dockerfiles/go/issues" \
      com.jitesoft.project.registry.uri="registry.gitlab.com/jitesoft/dockerfiles/go"
# Redefine version inside the build context.
ARG VERSION
ARG TARGETPLATFORM

ENV PATH="/usr/local/go/bin:$PATH" \
    GOPATH="/go" \
    GOOS="linux" \
    GOARCH="${TARGETPLATFORM}"

COPY --from=build /usr/local/go /usr/local/go

RUN mkdir -p "${GOPATH}/src" "${GOPATH}/bin" \
 && chmod -R 777 ${GOPATH} \
 && [ ! -e /etc/nsswitch.conf ] && echo 'hosts: files dns' > /etc/nsswitch.conf \
 && go version

WORKDIR /go
