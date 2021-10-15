# frozen_string_literal: true

module Onesie
  # Base Task class
  class Task
    def self.manual_task(state = false)
      define_method(:manual_task?) { state }
    end
  end
end
