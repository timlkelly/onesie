# frozen_string_literal: true

namespace :onesie do
  desc 'Generates a new Onesie Task'
  task :new, [:name] do |_t, args|
    Rails::Generators.invoke('onesie:task', [args.fetch(:name)])
  end

  desc 'Manually run a specific Onesie Tasks'
  task :run, [:version] do |_t, args|
    task_version = args[:version]
    Onesie::Manager.new.run_task(task_version)
  end

  desc 'Run all unprocessed Onesie Tasks'
  task :run_all do
    Onesie::Manager.new.run_all
  end
end
