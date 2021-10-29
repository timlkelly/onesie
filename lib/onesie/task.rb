# frozen_string_literal: true

module Onesie
  # Base Task class
  class Task
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
  end
end
