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

* [Docker hub](https://hub.docker.com/r/jitesoft/go): `jitesoft/go`  
* [GitLab](https://gitlab.com/jitesoft/dockerfiles/go): 
    * `registry.gitlab.com/jitesoft/dockerfiles/go`
    * `registry.gitlab.com/jitesoft/dockerfiles/go/ubuntu`
    * `registry.gitlab.com/jitesoft/dockerfiles/go/debian`
* [Quay.io](https://quay.io/jitesoft/go): `quay.io/jitesoft/go`
* [GitHub](https://github.com/orgs/jitesoft/packages/container/package/go): `ghcr.io/jitesoft/go`

## Docker files

Docker files can be found at  [GitLab](https://gitlab.com/jitesoft/dockerfiles/go) or [GitHub](https://github.com/jitesoft/docker-go)

### Image labels

This image follows the [Jitesoft image label specification 1.0.0](https://gitlab.com/snippets/1866155).

### Licenses

Repository files are released under the MIT license.  
Read the Go license [here](https://github.com/golang/go/blob/master/LICENSE).

### Sponsors

Jitesoft images are built via GitLab CI on runners hosted by the following wonderful organisations:

[![Fosshost Logo](https://raw.githubusercontent.com/jitesoft/misc/master/sponsors/fosshostx128.png)](https://fosshost.org)
[![Aarch64 logo](https://raw.githubusercontent.com/jitesoft/misc/master/sponsors/aarch64x128.png)](https://aarch64.com)

_The companies above are not affiliated with Jitesoft or any Jitesoft Projects directly._

---

Sponsoring is vital for the further development and maintaining of open source.  
Questions and sponsoring queries can be made by <a href="mailto:sponsor@jitesoft.com">email</a>.  
If you wish to sponsor our projects, reach out to the email above or visit any of the following sites:

[Open Collective](https://opencollective.com/jitesoft-open-source)  
[GitHub Sponsors](https://github.com/sponsors/jitesoft)  
[Patreon](https://www.patreon.com/jitesoft)
