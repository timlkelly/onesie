# frozen_string_literal: true

module Onesie
  # Responsible managing the Task files
  class Manager
    TASK_FILENAME_REGEX = /\A([0-9]+)_([_a-z0-9]*)\.?([_a-z0-9]*)?\.rb\z/.freeze

    class << self
      attr_accessor :tasks_path
    end

    # TODO: DRY the TASKS_DIR constant
    self.tasks_path = 'onesie/tasks'

    def initialize(runner: Onesie::Runner)
      @runner = runner
    end

    def run_all
      Task::Priority.constants.each do |const|
        run_tasks(priority_level: Task::Priority.const_get(const))
      end
      run_tasks
    end

    def run_tasks(priority_level: nil)
      filter_tasks(priority_level).each(&:run)
    end

    def run_task(task_version)
      task = tasks.find { |t| t.version == task_version }

      raise TaskNotFoundError, task_version if task.nil?

      runner.perform(task)
    end

    def filter_tasks(priority_level)
      @tasks_hash ||= Hash.new do |h, k|
        h[k] = tasks.select { |task| task.priority == priority_level }
      end
      @tasks_hash[priority_level]
    end

    def tasks
      @tasks ||= task_files.map do |file|
        version, name, priority = parse_task_filename(file)
        priority = nil if priority.empty?

        TaskProxy.new(name.camelize, version, file, priority)
      end
    end

    private

    attr_reader :runner

    def task_files
      Dir["#{self.class.tasks_path}/**/[0-9]*_*.rb"]
    end

    def parse_task_filename(filename)
      File.basename(filename).scan(TASK_FILENAME_REGEX).first
    end
  end
end
