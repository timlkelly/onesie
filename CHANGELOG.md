# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Added `.DS_Store` to `.gitignore`

### Changed

### Deprecated

### Removed
- Removed `bpdocs.yml`

### Fixed
- Fix documentation formatting for MKDocs

### Security

## [0.2.0] - 2022-02-01

### Added
- Add ability to rerun Tasks
- Add `onesie:rerun` rake task

### Changed
- Updated documentation of manual tasks
- Add documentation examples
- Added Onesie task name to "Done" message for logging

### Fixed
- Fix documentation typos
- Fix the Runner's error output to reference the correct task

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

[Unreleased]: https://github.com/timlkelly/onesie/compare/v0.2.0...HEAD
[0.2.0]: https://github.com/timlkelly/onesie/compare/v0.1.1...v0.2.0
[0.1.1]: https://github.com/timlkelly/onesie/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/timlkelly/onesie/releases/tag/v0.1.0
