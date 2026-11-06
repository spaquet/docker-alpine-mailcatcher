# Docker Alpine MailCatcher

[![Docker Image CI](https://github.com/spaquet/docker-alpine-mailcatcher/actions/workflows/docker-image.yml/badge.svg)](https://github.com/spaquet/docker-alpine-mailcatcher/actions/workflows/docker-image.yml)
[![GitHub release](https://img.shields.io/github/v/release/spaquet/docker-alpine-mailcatcher)](https://github.com/spaquet/docker-alpine-mailcatcher/releases/)
[![Docker Pulls](https://img.shields.io/docker/pulls/stpaquet/alpinemailcatcher)](https://hub.docker.com/r/stpaquet/alpinemailcatcher)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**MailCatcher NG on the latest Alpine Linux.** Catch every email your application sends, and read them in a web UI, without delivering anything to real recipients.

- SMTP server on port **1025**
- Web interface on port **1080**
- Small image, built on Alpine Linux

## Quick start

```bash
docker run -d --name mailcatcher -p 1080:1080 -p 1025:1025 stpaquet/alpinemailcatcher
```

1. Point your application's SMTP settings at `localhost:1025`.
2. Open [http://localhost:1080](http://localhost:1080) to read the captured messages.

On Docker Machine setups (Windows or older Mac), use the Docker Machine IP instead of `localhost`.

## Configuration

Set these with `-e` on `docker run` or in a `docker-compose.yml` file.

| Variable    | Default       | Description                                  |
| ----------- | ------------- | -------------------------------------------- |
| `MAIL_LIMIT` | `50`         | Maximum number of messages kept in memory    |
| `TIMEZONE`  | `UTC`         | Timezone used inside the container           |
| `LANG`      | `en_US.UTF-8` | Locale                                       |
| `LC_ALL`    | `en_US.UTF-8` | Locale                                       |
| `LANGUAGE`  | `en_US.UTF-8` | Language                                     |

Example: keep up to 60 messages.

```bash
docker run -d --name mailcatcher -p 1080:1080 -p 1025:1025 -e MAIL_LIMIT=60 stpaquet/alpinemailcatcher
```

### Changing ports

The ports inside the container are fixed. Change the host side of the mapping instead. This example exposes the web UI on `3080` and SMTP on `3025`:

```bash
docker run -d --name mailcatcher -p 3080:1080 -p 3025:1025 stpaquet/alpinemailcatcher
```

## Docker Compose

```yaml
services:
  mailcatcher:
    image: stpaquet/alpinemailcatcher:latest
    container_name: mailcatcher
    restart: on-failure:10
    environment:
      - MAIL_LIMIT=70
      - TIMEZONE=America/Los_Angeles
    ports:
      - "1080:1080"
      - "1025:1025"
```

## Message persistence

By default messages live in memory and are lost when the container stops. To store them in SQLite, mount a volume on the MailCatcher home directory and start MailCatcher with `--persistence`:

```bash
docker run -d --name mailcatcher \
  -p 1080:1080 -p 1025:1025 \
  -v mailcatcher-data:/home/mailcatcher/.mailcatcher \
  stpaquet/alpinemailcatcher \
  sh -c "mailcatcher --foreground --smtp-port=1025 --http-port=1080 --ip=0.0.0.0 --messages-limit=50 --persistence"
```

The database is stored at `/home/mailcatcher/.mailcatcher/mailcatcher.db` inside the container.

With Docker Compose:

```yaml
services:
  mailcatcher:
    image: stpaquet/alpinemailcatcher:latest
    ports:
      - "1080:1080"
      - "1025:1025"
    volumes:
      - mailcatcher-data:/home/mailcatcher/.mailcatcher
    command: sh -c "mailcatcher --foreground --smtp-port=1025 --http-port=1080 --ip=0.0.0.0 --messages-limit=$$MAIL_LIMIT --persistence"

volumes:
  mailcatcher-data:
```

## Pulling and upgrading

```bash
docker pull stpaquet/alpinemailcatcher:latest
```

If `docker pull` fails with `unauthorized: please use personal access token`, your Docker Hub account uses 2FA. Create a [Docker Hub access token](https://docs.docker.com/docker-hub/access-tokens/), then run `docker login --username <username>` and use the token as the password.

## Versions

| Component      | Version   |
| -------------- | --------- |
| Alpine Linux   | 3.24.4    |
| MailCatcher NG | 1.7.0     |
| Ruby           | 3.4.9     |
| SQLite         | 3.54.1    |

Ruby and SQLite versions can change when the image is rebuilt. To list every installed package in a running container:

```bash
docker exec -i mailcatcher apk info -vv | sort
```

## Supported architectures

- `linux/amd64` (x86_64)
- `linux/arm64` (Apple Silicon, ARM servers)
- `linux/386` (x86_32)
- `linux/arm/v7` and `linux/arm/v6`

Need another architecture? Update the [Dockerfile](https://github.com/spaquet/docker-alpine-mailcatcher/blob/master/Dockerfile) and open a pull request.

## Documentation and links

- [Usage guide](https://spaquet.github.io/docker-alpine-mailcatcher/): install, run, persistence, and configuration in more detail
- [Changelog](https://github.com/spaquet/docker-alpine-mailcatcher/blob/master/CHANGELOG.md): every release and what changed
- [Beginner guide (Medium)](https://medium.com/@spaquet/mailcatcher-to-the-rescue-4ba438dc98c2): MailCatcher with Docker and Docker Compose
- [MailCatcher NG](https://github.com/spaquet/mailcatcher): the MailCatcher fork this image packages ([website](https://spaquet.github.io/mailcatcher/))

## License

Released under the [MIT License](https://github.com/spaquet/docker-alpine-mailcatcher/blob/master/LICENSE).
