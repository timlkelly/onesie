# frozen_string_literal: true

module Onesie
  # Responsible managing the Task files
  class Manager
    TASK_FILENAME_REGEX = /\A([0-9]+)_([_a-z0-9]*)\.?([_a-z0-9]*)?\.rb\z/.freeze

    class << self
      attr_accessor :tasks_path
    end

    self.tasks_path = 'onesie/tasks'

    def initialize(runner: Onesie::Runner)
      @runner = runner
    end

    def pending_tasks
      tasks.reject { |task_proxy| completed_tasks.include?(task_proxy.filename) }
    end

    def pending_tasks?
      pending_tasks.any?
    end

    def run_all
      run_tasks(priority_level: Task::Priority::HIGH)
      run_tasks
    end

    def run_tasks(priority_level: nil)
      tasks = filter_tasks(priority_level)
      runner.perform(tasks)
    end

    def run_task(filename)
      task = find_task(filename)
      runner.perform(task, manual_override: true)
    end

    def tasks
      @tasks ||= task_files.map do |file|
        version, name, priority = parse_task_filename(file)
        priority = nil if priority.empty?

        TaskProxy.new(name.camelize, version, file, priority)
      end
    end

    def rerun(filename: nil)
      task = filename ? find_task(filename) : last_task
      task.delete
      runner.perform(task, manual_override: true)
    end

    private

    attr_reader :runner

    def completed_tasks
      @completed_tasks ||= Set.new(Onesie::TaskRecord.all_tasks)
    end

    def filter_tasks(priority_level)
      @tasks_hash ||= Hash.new do |hash, priority_level_key|
        hash[priority_level_key] = tasks.select do |task_proxy|
          task_proxy.priority == priority_level_key
        end
      end
      @tasks_hash[priority_level]
    end

    def find_task(filename)
      task = tasks.find { |task_proxy| task_proxy.filename == filename }
      raise TaskNotFoundError, filename if task.nil?

      task
    end

    def last_task
      tasks.max_by(&:version)
    end

    def parse_task_filename(filename)
      File.basename(filename).scan(TASK_FILENAME_REGEX).first
    end

    def task_files
      Dir["#{self.class.tasks_path}/**/[0-9]*_*.rb"]
    end
  end
end
