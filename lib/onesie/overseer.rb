# frozen_string_literal: true

module Onesie
  # Oversees running Onesie Tasks
  class Overseer
    def initialize
      load_tasks
    end

    def run
      Onesie::Tasks.constants.each do |const|
        ActiveRecord::Base.transaction do
          klass = Onesie::Tasks.const_get(const)
          klass.class_eval { prepend Onesie::TaskWrapper }
          klass.new.run
        rescue StandardError => e
          puts error_message(const).red
          raise e
        end
      end
    end

    private

    def error_message(const)
      <<~MSG
        \n
        An error occured while running #{const} task.
        All further tasks did not run.
      MSG
    end

    def load_tasks
      Pathname(Onesie::TASKS_DIR).children.each { |child| load child }
    end
  end
end
