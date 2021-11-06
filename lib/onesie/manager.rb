# frozen_string_literal: true

module Onesie
  # Responsible managing the Task files
  class Manager
    TASK_FILENAME_REGEX = /\A([0-9]+)_([_a-z0-9]*)\.?([_a-z0-9]*)?\.rb\z/.freeze

    class << self
      attr_accessor :tasks_paths
    end

    # DRY the TASKS_DIR constant
    self.tasks_paths = ['onesie/tasks']

    def tasks
      task_files.map do |file|
        version, name, _scope = parse_task_filename(file)

        TaskProxy.new(name.camelize, version, file, _scope)
      end
    end

    private

    def task_files
      Dir["#{self.class.tasks_paths.first}/**/[0-9]*_*.rb"]
    end

    def parse_task_filename(filename)
      File.basename(filename).scan(TASK_FILENAME_REGEX).first
    end
  end
end
