# frozen_string_literal: true

namespace :onesie do
  desc 'Generates a new Onesie Task'
  task :new, [:name, :priority] do |_t, args|
    name = args.fetch(:name)
    priority = args.fetch(:priority, nil)

    Rails::Generators.invoke('onesie:task', [name, priority])
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

  desc 'Run all high priority tasks'
  task :run_high_priority_tasks do
    Onesie::Manager.new.run_tasks(priority_level: Onesie::Task::Priority::HIGH)
  end

  desc 'Run all long_running priority tasks'
  task :run_long_running_tasks do
    Onesie::Manager.new.run_tasks(priority_level: Onesie::Task::Priority::LONG_RUNNING)
  end

  desc 'Run all maintenance priority tasks'
  task :run_maintenance_tasks do
    Onesie::Manager.new.run_tasks(priority_level: Onesie::Task::Priority::MAINTENANCE)
  end

  desc 'Run all tasks without any priority level'
  task :run_tasks do
    Onesie::Manager.new.run_tasks
  end
end
