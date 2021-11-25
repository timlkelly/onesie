# frozen_string_literal: true

module Onesie
  # Base Task class
  class Task
    module Priority
      HIGH         = 'high'
      LONG_RUNNING = 'long_running'
      MAINTENANCE  = 'maintenance'
    end

    # Class macro to define #allowed_environment? guard method
    #
    # @api public
    # @param envs [String, Symbol] the names of the allowed environments for
    #  a Task
    # @example Declare the allowed environments
    #  allowed_environments :integration, :staging
    # @return [Symbol]
    def self.allowed_environments(*envs)
      instance_variable_set(:@envs, envs.map(&:to_s))

      define_method(:allowed_environment?) do
        envs = self.class.instance_variable_get(:@envs)
        envs.include?(Rails.env) || envs.include?('all')
      end
    end

    # Class macro to define #manual_task? guard method
    #
    # @api public
    # @param enabled [Boolean]
    # @example Declare if a Task can only be run manually
    #  manual_task enabled: true
    # @return [Symbol]
    def self.manual_task(enabled: false)
      define_method(:manual_task?) { enabled }
    end

    def initialize(name = self.class.name, version = nil)
      @name = name
      @version = version
    end

    private

    attr_reader :name, :version

    # Creates a TaskRecord entry for the Task
    #
    # @api private
    # @return [TaskRecord]
    def record_task
      TaskRecord.create!(name: name, version: version)
    end

    # Checks if this Task's TaskRecord is present in the database
    #
    # @api private
    # @return [Boolean]
    def task_record_present?
      TaskRecord.find_by(name: name, version: version).present?
    end
  end
end
