FROM registry.gitlab.com/jitesoft/dockerfiles/go/ubuntu:bootstrap as build
ARG VERSION

COPY ./go${VERSION}.src.tar.gz /tmp/go.tar.gz

RUN apt-get update \
 && apt-get install -y gcc openssl ca-certificates \
 && tar -C /usr/local -xzf /tmp/go.tar.gz \
 && rm -f /tmp/go.tar.gz \
 && cd /usr/local/go/src \
 && ./make.bash \
 && rm -rf /usr/local/go/pkg/bootstrap /usr/local/go/pkg/obj

FROM registry.gitlab.com/jitesoft/dockerfiles/ubuntu:bionic
LABEL maintainer="Johannes Tegnér <johannes@jitesoft.com>" \
      maintainer.org="Jitesoft" \
      maintainer.org.uri="https://jitesoft.com" \
      com.jitesoft.project.repo.type="git" \
      com.jitesoft.project.repo.uri="https://gitlab.com/jitesoft/dockerfiles/go" \
      com.jitesoft.project.repo.issues="https://gitlab.com/jitesoft/dockerfiles/go/issues" \
      com.jitesoft.project.registry.uri="registry.gitlab.com/jitesoft/dockerfiles/go/ubuntu"

ENV PATH="/usr/local/go/bin:$PATH" \
    GOPATH="/go" \
    GOOS="linux" \
    GOARCH="amd64"

COPY --from=build /usr/local/go /usr/local/go

RUN  mkdir -p "${GOPATH}/src" "${GOPATH}/bin" \
 && chmod -R 777 ${GOPATH} \
 && go version

WORKDIR /go
