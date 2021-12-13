# frozen_string_literal: true

module Onesie
  OnesieError = Class.new(StandardError)

  # Raised when there is no matching Task for the provided Task filename.
  class TaskNotFoundError < OnesieError
    def initialize(filename)
      super("No Task found with filename: #{filename}")
    end
  end
end
