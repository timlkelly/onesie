# frozen_string_literal: true

namespace :onesie do
  desc 'Run all unprocessed Onesie Tasks'
  task run: [:environment] do
    Onesie::Overseer.new.run
  end

  desc 'Generates a new Onesie Task'
  task :new, [:name] => [:environment] do |_t, args|
    Rails::Generators.invoke('onesie:task', [args.fetch(:name)])
  end
end
