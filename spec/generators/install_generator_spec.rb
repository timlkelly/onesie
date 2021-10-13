# frozen_string_literal: true

require 'generator_spec'
require 'generators/onesie/install_generator'

RSpec.describe Onesie::Generators::InstallGenerator, type: :generator do
  destination File.expand_path('../../tmp', __dir__)

  before do
    prepare_destination
    run_generator
  end

  it 'creates a new task file' do
    assert_migration 'db/migrate/create_onesie_logs_table.rb', /create_table :onesie_logs/
  end
end
