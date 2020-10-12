# Go

[![Docker Pulls](https://img.shields.io/docker/pulls/jitesoft/go.svg)](https://cloud.docker.com/u/jitesoft/repository/docker/jitesoft/go)
[![Back project](https://img.shields.io/badge/Open%20Collective-Tip%20the%20devs!-blue.svg)](https://opencollective.com/jitesoft-open-source)

Docker image containing [Go](https://golang.org/).  
This image contains nothing but go and is intended as a base image to derive from in other docker files.
This means that the user running go is currently a root user. Make sure you create a new user when deriving from the
image so that your user does not run as root if not actually required.

## Image/Tags

Docker Hub and GitLab images are built for amd64, arm64 and arm/v7.

Each image is tagged with the version number and their respective distro separated with `-` (check tags for more information) while the non-distro tagged images are based on Alpine linux.

Images can be found at:

* Docker hub: `jitesoft/go`  
* GitLab: 
    * `registry.gitlab.com/jitesoft/dockerfiles/go`
    * `registry.gitlab.com/jitesoft/dockerfiles/go/ubuntu`
    * `registry.gitlab.com/jitesoft/dockerfiles/go/debian`
* Quay.io: `quay.io/jitesoft/go`
* GitHub: `ghcr.io/jitesoft/go`

## Docker files

Docker files can be found at  [GitLab](https://gitlab.com/jitesoft/dockerfiles/go) or [GitHub](https://github.com/jitesoft/docker-go)

### Image labels

This image follows the [Jitesoft image label specification 1.0.0](https://gitlab.com/snippets/1866155).

### Licenses

Repository files are released under the MIT license.  
Read the Go license [here](https://github.com/golang/go/blob/master/LICENSE).
