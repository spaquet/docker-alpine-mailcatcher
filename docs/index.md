Docker Mailcatcher using the latest Alpine Linux.

## Status

[![Docker Image CI](https://github.com/spaquet/docker-alpine-mailcatcher/actions/workflows/docker-image.yml/badge.svg)](https://github.com/spaquet/docker-alpine-mailcatcher/actions/workflows/docker-image.yml)

## License

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Components & Versions

| component     | version  |
|---------------|----------|
| Alpine Linux  | 3.16.0   |
| MailCatcher   | 0.8.2    |
| Ruby          | 3.1.2-r0 |
| SQLite        | 3.36.0-r0 |

Ruby & SQlite versions may differ as they are updated during the installation of the image. A full list of the installed packages can be extracted using the following command `docker exec -i <image_name> apk info -vv | sort`

## Supported Architectures

* x86_64
* arm64 (apple M1, etc.)
* x386, x86_32
* arm v7 and v6

Should you need additional architecture, update the ***Dockerfile*** and submit your PR for review.

## Latest version

[![GitHub release](https://img.shields.io/github/release/spaquet/docker-alpine-mailcatcher.svg)](https://GitHub.com/spaquet/docker-alpine-mailcatcher/releases/)

## Usage

### Install it

Run `docker pull stpaquet/alpinemailcatcher` from Terminal to install the image on your computer.

Once the installation has completed with success you can run the following command `docker images` and you should see the following output (with more or less line depending on the number of containers already installed on your computer)<br>
![](images/MailCatcher_sc_001.png)

### Pull / Upgrade
Pulling or upgrading to the latest version is done via<br>
`docker pull stpaquet/alpinemailcatcher:latest`

#### How-to

A beginner guide to install Mailcatcher using a docker image and docker compose can be found here:
[https://medium.com/@spaquet/mailcatcher-to-the-rescue-4ba438dc98c2](https://medium.com/@spaquet/mailcatcher-to-the-rescue-4ba438dc98c2)

### Access Token

Docker users using 2FA might encounter the following error message: `Error response from daemon: Head "https://registry-1.docker.io/v2/stpaquet/alpinemailcatcher/manifests/latest": unauthorized: please use personal access token to login`

In that case they must follow the following procedure [to set up an access token.](https://docs.docker.com/docker-hub/access-tokens/).

Once the access token created, they must login to their docker machine: `docker login --username <username>` and enter their access token when prompted.

### Run it

There are different options when it comes to running this images. Here are our most favorite ones:

#### ... and delete it right away

`docker run --rm -p 1080:1080 -p 1025:1025 --name mailcatcher stpaquet/alpinemailcatcher`

#### ... as a daemon

`docker run -d -p 1080:1080 -p 1025:1025 --name mailcatcher stpaquet/alpinemailcatcher`

#### ... change `--messages-limit` value

The default value is 50, but this value can be changed when launching the docker image using the following command: `docker run -d -p 1080:1080 -p 1025:1025 -e MAIL_LIMIT=60 --name mailcatcher stpaquet/alpinemailcatcher`<br>
In the above example the value is raised to 60.

As this value is defined as an environment variable it can be modified in different ways, including using a ***docker-compose*** file.

#### ... other environment variables and their default values

##### LANG="en_US.UTF-8"

##### LC_ALL="en_US.UTF-8"

##### LANGUAGE="en_US.UTF-8"

##### TIMEZONE="UTC"

All of the above variables can be changed at run time using the `-e` flag or included in a ***docker-compose*** file.

#### ... Changing port (& running as a daemon)

In this version you cannot change the ports being used in the image. However, you can change the port translation.
If ports 1080 or 1025 are used by an other application or service on your computer you can change these values the following way:<br>
`docker run -d -p 3080:1080 -p 3025:1025 --name mailcatcher`

### Access it

Just point your favorite web browser to MailCatcher image IP address if on Linux or to docker-machine IP address if on a Mac or Windows PC.

##### When using Docker-Machine (Mac & Windows users)

On Mac and Windows you do not run docker directly, but through ***docker-machine***. This implies that you will not access MailCatcher web interface using the IP address of the container, but the docker-machine one.

To get the IP address of your docker-machine run the following command:
`docker-machine env dev` (assuming your docker machine is named *dev*<br>

```
export DOCKER_TLS_VERIFY="1"
export DOCKER_HOST="tcp://192.168.99.100:2376"
export DOCKER_CERT_PATH="/Users/username/.docker/machine/machines/dev"
export DOCKER_MACHINE_NAME="dev"
```

In this case, to access MailCatcher web interface you need to enter `http://192.168.99.100:1080`

###### Nota I

When using ***docker-machine*** do not forget to run `eval $(docker-machine env dev)` to configure your shell. If your shell is not properly configured you will not be able to run docker commands. Thus installing or running MailCatcher using this docker image will not work.

###### Nota II

Newer versions of ***docker desktop*** may not require the above when properly set up on a Mac as they properly bind to the localhost address of the machine being used.

## Ruby on Rails (Rails)

Add the following lines to your `environments/development.rb` to redirect your ActionMailer directly to MailCatcher:

```
config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = { address: '127.0.0.1', port: 1025 }
config.action_mailer.raise_delivery_errors = false
config.action_mailer.default_url_options = { host: "localhost", port: 3000 }
```

Make sure that the *port* and *address* are matching the one of your MailCatcher image, or *docker-machine* if you are on a Mac or PC running Windows.

## Misc.
Other programming languages and frameworks are supported. Refer to their mailer documentation for their optimal configuration. But, since Mailcatcher is a leight weight SMTP server, most of the case limit to pointing to the local instance of Mailcatcher runnig in Docker and use the port 1025.

## Known "issue"

MailCatcher is running in `foreground` mode. This does not change MailCatcher behavior and performances are not affected.

## History

| Version | Date       | Notes                      |
|---------|------------|----------------------------|
| 1.0     | 2017-08-07 | Initial release            |
| 1.1     | 2017-08-08 |                            |
| 1.2     | 2022-02-27 | Updated to Mailcatcher 0.8<br> Limit to 50 the number of emails saved in mailcatcher |
| 1.3     | 2022-02-27 | Enable users to change mail-limit value at run time |
| 1.4     | 2022-02-28 | Upgrading to Mailcatcher 0.8.1 |
| 1.5     | 2022-03-03 | Tighter control over the environment |
| 1.6     | 2022-03-04 | Upgrading to Mailcatcher 0.8.2 |
| 1.7     | 2022-03-17 | Upgrading Alpine Linux to 3.15.1<br>Partial fix [CVE-2022-0778](https://security.alpinelinux.org/vuln/CVE-2022-0778) |
| 1.7.1   | 2022-03-17 | Removing unnecessary packages  |
| 1.7.2   | 2022-03-17 | Removed a build layer |
| 1.7.3   | 2022-03-18 | Fixing [CVE-2022-0778](https://security.alpinelinux.org/vuln/CVE-2022-0778) once for all. In the previous versions, Libretls was outdated and offered a way to exploit CVE-2022-0778 |
| 1.7.4   | 2022-03-23 | Upgrading to Alpine Linux 3.15.2 which includes a fix for libretls [CVE-2022-0778](https://security.alpinelinux.org/vuln/CVE-2022-0778) and reverting to the default build process |
| 1.7.5   | 2022-03-31 | Upgrading to Alpine Linux 3.15.3 |
| 1.7.6   | 2022-04-05 | Upgrading to Alpine Linux 3.15.4 |
| 1.7.7   | 2022-05-25 | Upgrading to Alpine Linux 3.16.0 |
| 1.7.8   | 2022-05-30 | Fixing #5 - net-smtp was not properly loading when using ruby 3.1 |

## Wanna contribute?

Fork and pull your changes!<br>
To build run `docker build -t stpaquet/alpinemailcatcher`

### Local build

`git clone git@github.com:spaquet/docker-alpine-mailcatcher.git`<br>
`cd docker-alpine-mailcatcher`<br>
`docker run --rm -it -p 1080:1080 -p 1025:1025 --name mailcatcher $(docker build -q .)`

## Alpine MailCatcher @DockerHub

[https://hub.docker.com/r/stpaquet/alpinemailcatcher](https://hub.docker.com/r/stpaquet/alpinemailcatcher)

## Alpine MailCatcher on GitHub

[https://github.com/spaquet/docker-alpine-mailcatcher](https://github.com/spaquet/docker-alpine-mailcatcher)

## Official MailCatcher sites

Github: [https://github.com/sj26/mailcatcher](https://github.com/sj26/mailcatcher)<br>
Website: [https://mailcatcher.me/](https://mailcatcher.me/)

## Alpine Linux

Website: [https://alpinelinux.org/](https://alpinelinux.org/)
