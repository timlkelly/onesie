# frozen_string_literal: true

module Onesie
  # Responsible managing the Task files
  class Manager
    TASK_FILENAME_REGEX = /\A([0-9]+)_([_a-z0-9]*)\.?([_a-z0-9]*)?\.rb\z/.freeze

    class << self
      attr_accessor :tasks_paths
    end

    # TODO: DRY the TASKS_DIR constant
    self.tasks_paths = ['onesie/tasks']

    def initialize(runner: Onesie::Runner)
      @runner = runner
    end

    def run_all
      runner.perform(tasks)
    end

    def run_task(task_version)
      task = tasks.find { |t| t.version == task_version }

      raise TaskNotFoundError, task_version if task.nil?

      runner.perform(task)
    end

    def tasks
      task_files.map do |file|
        version, name, scope = parse_task_filename(file)

        TaskProxy.new(name.camelize, version, file, scope)
      end
    end

    private

    attr_reader :runner

    def task_files
      Dir["#{self.class.tasks_paths.first}/**/[0-9]*_*.rb"]
    end

    def parse_task_filename(filename)
      File.basename(filename).scan(TASK_FILENAME_REGEX).first
    end
  end
end
