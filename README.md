# Onesie

[![ci](https://github.com/watermelonexpress/onesie/actions/workflows/ci.yml/badge.svg)](https://github.com/watermelonexpress/onesie/actions/workflows/ci.yml)

Onesie is a Task runner for BenchPrep Rails applications.

## Installation
See the [installation guide](doc/how_to_guides/installation.md).

## Usage
See the [usage guide](doc/how_to_guides/usage.md).

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

[Guard][1] is setup for local development and will automatically run RSpec and
Rubocop upon file save. To make use of this, run `bundle exec guard`.

Add any changes to CHANGELOG under "Unreleased".

## How to publish a gem version
Note: Publishing to Github Packages registry requires authentication, see
Github's [guide][2] on how to work with the registry.

1. Increment the version number accordingly in `lib/onesie/version.rb`,
`doc/usage/installation.md`, and `README.md`
2. Update the CHANGELOG file to reflect the release
3. Commit the version and CHANGELOG changes
4. Build and tag the gem, using `gem_push=no` to prevent Bundler from pushing
to the RubyGems registry

```bash
gem_push=no rake release
```

5. Push the corresponding gem version to Github Packages registry

```bash
gem push --key github \
--host https://rubygems.pkg.github.com/watermelonexpress \
pkg/onesie-0.2.0.gem
```

[1]: https://github.com/guard/guard
[2]: https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-rubygems-registry
