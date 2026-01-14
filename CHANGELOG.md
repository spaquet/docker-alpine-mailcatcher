# Changelog

All notable changes to this project will be documented in this file.

## [2.3.4] - 2026-01-13

### Added
- **Claude Integration Support**: Complete integration with Claude through two complementary methods
  - **Claude Plugin**: HTTP-based plugin for Claude.com and Claude Desktop (`--plugin` flag)
    - Zero configuration required for plugin discovery
    - Dynamic OpenAPI spec generation for plugin compatibility
    - Natural language interface to all email tools
  - **MCP Server**: Model Context Protocol server for programmatic access (`--mcp` flag)
    - Full MCP 2024-11-05 protocol implementation
    - JSON-RPC 2.0 over stdio for reliability
    - Thread-safe operation within EventMachine reactor

- **Claude Integration Tools** (7 powerful tools exposed via Plugin and MCP):
  - `search_messages`: Full-text search with filtering (query, limit, attachments, date range)
  - `get_latest_message_for`: Find latest message for recipient with optional subject filtering
  - `extract_token_or_link`: Extract OTPs, magic links, reset tokens from messages
  - `get_parsed_auth_info`: Get structured authentication information
  - `get_message_preview_html`: Get responsive HTML preview with mobile optimization
  - `delete_message`: Delete specific message by ID
  - `clear_messages`: Delete all caught messages

- **Plugin HTTP Endpoints**:
  - `GET /.well-known/ai-plugin.json`: Standard AI plugin manifest
  - `GET /plugin/openapi.json`: Dynamic OpenAPI specification
  - `POST /plugin/search`: Message search
  - `GET /plugin/message/:id/latest`: Get latest for recipient
  - `GET /plugin/message/:id/tokens`: Extract tokens
  - `GET /plugin/message/:id/auth-info`: Get auth information
  - `GET /plugin/message/:id/preview`: Get HTML preview
  - `DELETE /plugin/messages`: Clear all
  - `DELETE /plugin/message/:id`: Delete single

### Changed
- Upgraded Mailcatcher NG from v1.4.x to v1.5.2
- Added support for Claude integration flags (`--mcp`, `--plugin`)
- Version bumped from 2.2.1 to 2.3.4

### Technical Details
- New optional integration layer for Claude
- Single source of truth for tools (MCPTools module)
- Protocol-independent tool implementation
- Zero breaking changes to existing functionality

## [2.2.0] - 2026-01-12

### Added
- **Message Persistence**: Added support for Mailcatcher NG 1.4.0's `--persistence` flag to store messages in a persistent SQLite database
- **Non-root User**: Container now runs as a non-root `mailcatcher` user (UID 1000) for improved security
- Documentation on how to enable persistence with both `docker run` and `docker-compose`
- Commented examples in `docker-compose.yml` for enabling persistence

### Changed
- Upgraded Mailcatcher NG from v1.3.x to v1.4.0
- Changed container user from `root` to `mailcatcher` (UID 1000)
- Updated persistence storage location from `/root/.mailcatcher` to `/home/mailcatcher/.mailcatcher`
- Version bumped from 2.1.0 to 2.2.0

### Security
- Container now runs with limited permissions as non-root user instead of as root

## [2.1.0] - 2026-01-11

### Added
- Upgraded to Mailcatcher NG v1.3.1
- SMTP Transcripts support
- Code optimization and refactoring

## [2.0.2] - 2026-01-10

### Changed
- Upgraded to Mailcatcher NG v1.2.0

## [2.0.1] - 2026-01-09

### Changed
- Upgraded to Mailcatcher NG v0.12.0

## [2.0.0] - 2026-01-09

### Changed
- Custom mailcatcher build implementation

## [1.9.1] - 2026-01-08

### Changed
- Optimized docker image size (~49MB)

## [1.9.0] - 2026-01-08

### Changed
- Upgraded to Alpine Linux 3.23.2
- Upgraded to Ruby 3.4.8
- Upgraded to Mailcatcher v0.10.0

## [1.8.3] - 2023-10-09

### Fixed
- Fixed a bug affecting Mac M1 (and likely M2)

## [1.8.2] - 2023-10-08

### Added
- Added support for linux/arm64/v8 architecture

## [1.8.1] - 2023-10-06

### Changed
- Upgraded to Alpine Linux 3.18.4
- Upgraded to Mailcatcher v0.9.0

## [1.7.11] - 2022-11-28

### Changed
- Upgraded to Alpine Linux 3.17.0
- Upgraded to Mailcatcher v0.9.0.beta1

## [1.7.10] - 2022-08-16

### Changed
- Upgraded to Alpine Linux 3.16.2

## [1.7.9] - 2022-08-02

### Security
- Fixed CVE-2022-30065 (busybox)
- Fixed CVE-2022-2097 (openssl)
- Upgraded to Alpine Linux 3.16.1

## [1.7.8] - 2022-05-30

### Fixed
- Fixed net-smtp loading issue with Ruby 3.1

## [1.7.7] - 2022-05-25

### Changed
- Upgraded to Alpine Linux 3.16.0

## [1.7.6] - 2022-04-05

### Changed
- Upgraded to Alpine Linux 3.15.4

## [1.7.5] - 2022-03-31

### Changed
- Upgraded to Alpine Linux 3.15.3

## [1.7.4] - 2022-03-23

### Security
- Fixed CVE-2022-0778 (libretls)
- Upgraded to Alpine Linux 3.15.2

## [1.7.3] - 2022-03-18

### Security
- Fixed CVE-2022-0778

## [1.7.2] - 2022-03-17

### Changed
- Removed a build layer

## [1.7.1] - 2022-03-17

### Changed
- Removed unnecessary packages

## [1.7] - 2022-03-17

### Security
- Partial fix for CVE-2022-0778
- Upgraded to Alpine Linux 3.15.1

## [1.6] - 2022-03-04

### Changed
- Upgraded to Mailcatcher v0.8.2

## [1.5] - 2022-03-03

### Changed
- Tighter control over the environment

## [1.4] - 2022-02-28

### Changed
- Upgraded to Mailcatcher v0.8.1

## [1.3] - 2022-02-27

### Added
- Enable users to change mail-limit value at run time

## [1.2] - 2022-02-27

### Changed
- Updated to Mailcatcher v0.8
- Limited email storage to 50 messages by default

## [1.1] - 2017-08-08

## [1.0] - 2017-08-07

### Added
- Initial release
