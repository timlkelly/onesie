# frozen_string_literal: true

module Onesie
  # TaskProxy is a stand in for the actual Task until the class is needed
  TaskProxy = Struct.new(:name, :version, :file_path, :priority) do
    def initialize(name, version, file_path, priority)
      super
      @task = nil
    end

    delegate :run, to: :task

    def delete
      task_record.delete
    end

    def filename
      file_path.match(/([0-9]+_[_a-z0-9]+)/).captures.first
    end

    private

    def task
      @task ||= load_task
    end

    def task_record
      TaskRecord.find_by!(name: name, version: version)
    end

    # Override default Struct behavior with Kernel#Array
    def to_ary
      [self]
    end

    def load_task
      require(File.expand_path(file_path))
      klass = "Onesie::Tasks::#{name}".constantize
      klass.class_eval { prepend Onesie::TaskWrapper }
      klass.new(name, version)
    end
  end
end
