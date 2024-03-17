# frozen_string_literal: true

using Rainbow

module Onesie
  # The Runner is responsible for running tasks, recording errors, and printing
  # the output
  class Runner
    attr_reader :errors, :manual_override, :tasks

    # @param tasks [TaskProxy, Array<TaskProxy>]
    # @param manual_override [Boolean] allows for running manual tasks
    def self.perform(tasks, manual_override: false)
      new(tasks, manual_override: manual_override).perform
    end

    # @param tasks [TaskProxy, Array<TaskProxy>]
    # @param manual_override [Boolean] allows for running manual tasks
    def initialize(tasks, manual_override: false)
      @errors = {}
      @manual_override = manual_override
      @tasks = Array(tasks).sort_by(&:version)
    end

    def perform
      tasks.each do |task|
        task.run(manual_override: manual_override)
      rescue StandardError => e
        puts "An error occurred with #{task.name}".red
        errors[task.name] = e
      end

      print_errors if errors.any?
    end

    private

    def print_errors
      puts "The following Tasks contained errors\n\n".red

      errors.each do |task_class, error|
        puts "#{task_class.red}: #{error.class} #{error.message}\n"
        puts error.full_message
        puts "\n"
      end
    end
  end
end
