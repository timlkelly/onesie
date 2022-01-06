# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

### Changed

### Deprecated

### Removed

### Fixed

### Security

## [0.1.1] - 2022-01-06

### Removed
- Removed unique index between `name` and `version` for PostgreSQL BDR
  compliance

### Fixed
- Add comment on `onesie_tasks.id` column
- Add uniqueness validation to `TaskRecord`
- Make migration reversible; Specified `up` and `down` actions

## [0.1.0] - 2021-09-29

- Initial release
- Setup Onesie Base
- Add manual Tasks
- Add Task environmental guard
- Add Task error handling
- Add Task priority levels
- Add onesie:describe rake task
- Change database tablename from `onesie_logs` to `onesie_tasks`

[Unreleased]: https://github.com/watermelonexpress/onesie/compare/v0.1.1...HEAD
[0.1.1]: https://github.com/watermelonexpress/onesie/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/watermelonexpress/onesie/releases/tag/v0.1.0
