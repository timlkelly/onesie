# frozen_string_literal: true

require_relative 'lib/onesie/version'

Gem::Specification.new do |spec|
  spec.name          = 'onesie'
  spec.version       = Onesie::VERSION
  spec.authors       = ['Benchprep']
  spec.email         = ['developers@benchprep.com']

  spec.summary       = 'BenchPrep Onesie Task Runner'
  spec.description   = ''
  spec.homepage      = 'https://github.com/watermelonexpress/onesie'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.6.3')

  spec.metadata['allowed_push_host'] = 'https://rubygems.pkg.github.com/watermelonexpress'
  spec.metadata['changelog_uri']     = 'https://github.com/watermelonexpress/onesie/blob/main/CHANGELOG.md'
  spec.metadata['github_repo']       = 'ssh://github.com/watermelonexpress/onesie'
  spec.metadata['homepage_uri']      = spec.homepage
  spec.metadata['source_code_uri']   = 'https://github.com/watermelonexpress/onesie'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'guard',               '~> 2.17'
  spec.add_development_dependency 'guard-rspec',         '~> 4.7'
  spec.add_development_dependency 'guard-rubocop',       '~> 1.5'
  spec.add_development_dependency 'rake',                '~> 13.0'
  spec.add_development_dependency 'rspec',               '~> 3.10'
  spec.add_development_dependency 'rubocop',             '~> 1.21'
  spec.add_development_dependency 'rubocop-performance', '~> 1.11'
  spec.add_development_dependency 'rubocop-rake',        '~> 0.5.1'
  spec.add_development_dependency 'rubocop-rspec',       '~> 2.5'

  spec.add_runtime_dependency 'activerecord', '~> 4.2.11.3'
  spec.add_runtime_dependency 'colorize',     '~> 0.8.1'
  spec.add_runtime_dependency 'railties',     '~> 4.2.11.3'
end
