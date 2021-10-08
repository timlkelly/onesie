# frozen_string_literal: true

require 'colorize'

module Onesie
  # Wraps Onesie Task
  # Responsible for checking if the Task has been ran already
  # and recording the Task
  module TaskWrapper
    def run
      return if task_record_present?

      puts "Running #{klass_name}...".magenta
      super
      record_task
      puts 'Done!'.green
    end

    private

    def klass_name
      self.class.name
    end

    def record_task
      TaskRecord.create!(task_name: klass_name)
    end

    def task_record_present?
      TaskRecord.find_by(task_name: klass_name).present?
    end
  end
end
