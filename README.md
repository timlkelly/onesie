# Onesie

[![ci](https://github.com/watermelonexpress/onesie/actions/workflows/ci.yml/badge.svg)](https://github.com/watermelonexpress/onesie/actions/workflows/ci.yml)

Onesie is a Task runner for BenchPrep Rails applications.

Installation and Usage documentation can be found in the `doc/` directory.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then
run `bundle exec rake release`, which will create a git tag for the version,
push git commits and the created tag, and push the `.gem` file
to [rubygems.org](https://rubygems.org).

[Guard][1] is setup for local development and will automatically run RSpec and
Rubocop upon file save. To make use of this, run `bundle exec guard`.

Add any changes to CHANGELOG under "Unreleased".

[1]: https://github.com/guard/guard
