# frozen_string_literal: true

require 'active_support'
require 'active_support/rails'

module Onesie
  OnesieError = Class.new(StandardError)

  class PendingTaskError < OnesieError # :nodoc:
    include ActiveSupport::ActionableError

    action 'Run pending Onesies' do
      Onesie::Manager.new.run_all
    end

    def initialize(message = nil)
      super(message || detailed_onesie_message)
    end

    private

    def detailed_onesie_message
      'Onesie Tasks are pending. To resolve this issue, run: rake onesie:run_all'
    end
  end

  # Raised when there is no matching Task for the provided Task filename.
  class TaskNotFoundError < OnesieError
    def initialize(filename)
      super("No Task found with filename: #{filename}")
    end
  end
end
