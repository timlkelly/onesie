# frozen_string_literal: true

directories %w[bin lib spec]

group :red_green_refactor, halt_on_fail: true do
  rspec_options = {
    cmd: 'bundle exec rspec',
    failed_mode: :focus
  }

  rubocop_options = {
    all_on_start: false,
    cli: ['--display-cop-names']
  }

  guard :rspec, rspec_options do
    watch(%r{^lib/(.+)\.rb$}) { |m| "spec/lib/#{m[1]}_spec.rb" }
    watch(%r{^spec/.+_spec\.rb$})
    watch('spec/spec_helper.rb') { 'spec' }
  end

  guard :rubocop, rubocop_options do
    watch('Gemfile')
    watch(/.+\.rb$/)
    watch(%r{(?:.+/)?\.rubocop(?:_todo)?\.yml$}) { |m| File.dirname(m[0]) }
  end
end
