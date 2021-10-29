# frozen_string_literal: true

module Onesie
  # Wraps Onesie Task
  # Responsible for checking if the Task has been ran already
  # and recording the Task
  # Prepend to the Task class prior to running
  module TaskWrapper
    def run(manual_override: false)
      return if task_record_present?
      return if !manual_override && manual_task?

      puts "Running #{class_name}...".magenta
      super()
      record_task
      puts 'Done!'.green
    end

    private

    def class_name
      self.class.name
    end

    def record_task
      TaskRecord.create!(task_name: class_name)
    end

    def task_record_present?
      TaskRecord.find_by(task_name: class_name).present?
    end
  end
end
