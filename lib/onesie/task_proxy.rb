# frozen_string_literal: true

module Onesie
  # TaskProxy is a stand in for the actual Task until the class is needed
  TaskProxy = Struct.new(:name, :version, :filename, :priority) do
    def initialize(name, version, filename, priority)
      super
      @task = nil
    end

    delegate :run, to: :task

    private

    def task
      @task ||= load_task
    end

    def load_task
      require(File.expand_path(filename))
      klass = "Onesie::Tasks::#{name}".constantize
      klass.class_eval { prepend Onesie::TaskWrapper }
      klass.new(name, version)
    end
  end
end
