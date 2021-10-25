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

    # Run a specific Onesie Task
    #
    # @api public
    # @example Manually run a specific task
    #  run_task(:MyTask, manual_override: true)
    # @param class_name [String, Symbol] the name of the Task to run
    # @param manual_override [Boolean] optional keyword argument to override
    #  the manual task guard
    # @return [String, nil]
    def run_task(class_name, manual_override: false)
      klass = Onesie::Tasks.const_get(class_name)
      klass.class_eval { prepend Onesie::TaskWrapper }
      klass.new.run(manual_override: manual_override)
    rescue StandardError => e
      puts error_message(class_name).red
      raise e
    end

    private

    # Error message for a failed Task
    #
    # @api private
    # @return [String]
    def error_message(const)
      <<~MSG
        \n
        An error occured while running #{const} task.
        All further tasks did not run.
      MSG
    end

    # Load all of the Onesie Tasks
    #
    # @api private
    # @return [Array<Pathname>]
    def load_tasks
      $LOAD_PATH << Bundler.root.to_s

      Pathname(Onesie::TASKS_DIR).children.each do |child|
        require child.to_s
      end
    end
  end
end
