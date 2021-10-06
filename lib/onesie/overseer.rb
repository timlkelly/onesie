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
        end
      end
    end

    private

    def load_tasks
      Pathname(Onesie::TASKS_DIR).children.each { |child| load child }
    end
  end
end
