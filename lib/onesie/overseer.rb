# frozen_string_literal: true

module Onesie
  # Oversees running Onesie Tasks
  class Overseer
    def initialize
      load_tasks
    end

    def run_all
      Onesie::Tasks.constants.each do |const|
        run_task(const)
      end
    end

    def run_task(class_name, manual_override: false)
      klass = Onesie::Tasks.const_get(class_name)
      klass.class_eval { prepend Onesie::TaskWrapper }
      klass.new.run(manual_override: manual_override)
    rescue StandardError => e
      puts error_message(class_name).red
      raise e
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
