# frozen_string_literal: true

namespace :onesie do
  # bundle exec rake onesie:new['MyTask']
  # bundle exec rake onesie:new['MyTask','high']
  desc 'Generates a new Onesie Task'
  task :new, [:name, :priority] do |_t, args|
    name = args.fetch(:name)
    priority = args.fetch(:priority, nil)

    Rails::Generators.invoke('onesie:task', [name, priority])
  end

  # bundle exec rake onesie:run['20211210232208_foo']
  desc 'Manually run a specific Onesie Tasks'
  task :run, [:filename] => :environment do |_t, args|
    filename = args[:filename]
    Onesie::Manager.new.run_task(filename)
  end

  desc 'Run all unprocessed Onesie Tasks'
  task run_all: :environment do
    Onesie::Manager.new.run_all
  end

  # bundle exec rake onesie:run_tasks
  # bundle exec rake onesie:run_tasks['high']
  desc 'Run all tasks by priority level'
  task :run_tasks, [:priority_level] => :environment do |_t, args|
    priority_level = args.fetch(:priority_level, nil)
    Onesie::Manager.new.run_tasks(priority_level: priority_level)
  end
end
