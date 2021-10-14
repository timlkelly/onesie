# frozen_string_literal: true

require 'generator_spec'
require 'generators/onesie/task_generator'

RSpec.describe Onesie::Generators::TaskGenerator, type: :generator do
  destination File.expand_path('../../../tmp', __dir__)
  arguments %w[TestTask]

  before do
    prepare_destination
    run_generator
  end

  it 'creates a new task file' do
    assert_file 'onesie/tasks/test_task.rb', /class TestTask/
  end
end
