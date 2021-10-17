# Onesie

[![ci](https://github.com/watermelonexpress/onesie/actions/workflows/ci.yml/badge.svg)](https://github.com/watermelonexpress/onesie/actions/workflows/ci.yml)

Onesie is a Task runner for BenchPrep Rails applications.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'onesie'
```

And then execute:

    $ bundle install

Generate and run the required migration file:

    $ bin/rails generate onesie:install
    $ bundle exec rake db:migrate

## Usage

Generate a new Onesie Task using either the Rails generator or the Rake task:

    $ bin/rails generate onesie:task MyFirstTask

    $ bundle exec rake onesie:new['MyFirstTask']

Add your code in the new generated template file. Make sure to make use of the
`#run` method. This is what will be executed when the Tasks are ran.

Run the Onesie tasks with the following Rake task

    $ bundle exec rake onesie:run

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
