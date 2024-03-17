# frozen_string_literal: true

using Rainbow

module Onesie
  # Wraps Onesie Task
  # Responsible for checking if the Task has been ran already
  # and recording the Task
  # Prepend to the Task class prior to running
  module TaskWrapper
    def run(manual_override: false)
      return unless allowed_environment?
      return if task_record_present?
      return if manual_task? && !manual_override

      puts "Running #{name}...".magenta
      super()
      record_task
      puts "Done running #{name}!".green
    end
  end
end
