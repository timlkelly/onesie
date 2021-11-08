# frozen_string_literal: true

namespace :onesie do
  desc 'Generates a new Onesie Task'
  task :new, [:name] => [:environment] do |_t, args|
    Rails::Generators.invoke('onesie:task', [args.fetch(:name)])
  end

  desc 'Manually run a specific Onesie Tasks'
  task :run, [:task_name] => [:environment] do
    Onesie::Manager.new.run_task(task_name, manual_override: true)
  end

  desc 'Run all unprocessed Onesie Tasks'
  task run_all: [:environment] do
    Onesie::Manager.new.run_all
  end
end
