Docker Mailcatcher using the latest Alpine Linux.

## Status
[![Docker Image CI](https://github.com/spaquet/docker-alpine-mailcatcher/actions/workflows/docker-image.yml/badge.svg)](https://github.com/spaquet/docker-alpine-mailcatcher/actions/workflows/docker-image.yml)

## License
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Components & Versions
| component     | version  |
|---------------|----------|
| Alpine Linux  | 3.18.4   |
| MailCatcher   | 0.9.0    |
| Ruby          | 3.2.0    |
| SQLite        | 3.43.1-r0 |

Ruby & SQlite versions may differ as they are updated during the installation of the image. A full list of the installed packages can be extracted using the following command `docker exec -i <image_name> apk info -vv | sort`

## Supported Architectures
* x86_64
* arm64 (apple M1, etc.)
* x386, x86_32
* arm v7 and v6

Should you need additional architecture, update the ***Dockerfile*** and submit your PR for review.

## Latest version
[![GitHub release](https://img.shields.io/github/release/spaquet/docker-alpine-mailcatcher.svg)](https://GitHub.com/spaquet/docker-alpine-mailcatcher/releases/)


## Usage & More Information

Please refer to [https://spaquet.github.io/docker-alpine-mailcatcher/](https://spaquet.github.io/docker-alpine-mailcatcher/)
