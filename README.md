# Go

[![Docker Pulls](https://img.shields.io/docker/pulls/jitesoft/go.svg)](https://cloud.docker.com/u/jitesoft/repository/docker/jitesoft/go)
[![pipeline status](https://gitlab.com/jitesoft/dockerfiles/go/badges/master/pipeline.svg)](https://gitlab.com/jitesoft/dockerfiles/go/commits/master)
[![Back project](https://img.shields.io/badge/Open%20Collective-Tip%20the%20devs!-blue.svg)](https://opencollective.com/jitesoft-open-source)

Docker image containing [Go](https://golang.org/).  
This image contains nothing but go and is intended as a base image to derive from in other docker files.
This means that the user running go is currently a root user. Make sure you create a new user when deriving from the
image so that your user does not run as root if not actually required.

## Tags

Docker Hub and GitLab images are built for amd64 and arm64.

### Docker Hub

* `jitesoft/go`
    * `1.13`, `latest` (alpine)
    * `1.13-ubunntu`, `latest-ubuntu`
    * `1.13-debian`, `latest-debian`

### GitLab

* `registry.gitlab.com/jitesoft/dockerfiles/go`
    * `1.13`, `latest`
    * `bootstrap` (go 1.11 for bootstrap compilation) 
* `registry.gitlab.com/jitesoft/dockerfiles/go/ubuntu`
    * `1.13`, `latest`
    * `bootstrap` (go 1.11 for bootstrap compilation) 
* `registry.gitlab.com/jitesoft/dockerfiles/go/debian`
    * `1.13`, `latest`
  
### Quay.io

* `quay.io/jitesoft/go`
    * `1.13`, `latest`
    * `1.13-ubuntu`, `latest-ubuntu`
    * `1.13-debian`, `latest-debian`

## Docker files

Docker files can be found at  [GitLab](https://gitlab.com/jitesoft/dockerfiles/go) or [GitHub](https://github.com/jitesoft/docker-go)

### Image labels

This image follows the [Jitesoft image label specification 1.0.0](https://gitlab.com/snippets/1866155).

### Licenses

Repository files are released under the MIT license.  
Read the Go license [here](https://github.com/golang/go/blob/master/LICENSE).
