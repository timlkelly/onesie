# frozen_string_literal: true

module Onesie
  # Wraps Onesie Task
  # Responsible for checking if the Task has been ran already
  # and recording the Task
  # Prepend to the Task class prior to running
  module TaskWrapper
    def run(manual_override: false)
      return unless allowed_environment?
      return if task_record_present?
      return if !manual_override && manual_task?

      puts "Running #{class_name}...".magenta
      super()
      record_task
      puts 'Done!'.green
    end
  end
end
