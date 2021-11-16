# frozen_string_literal: true

module Onesie
  OnesieError = Class.new(StandardError)

  # Raised when there is no matching Task for the provided Task Version.
  class TaskNotFoundError < OnesieError
    def initialize(task_version)
      super("No Task found with version number: #{task_version}")
    end
  end
end
