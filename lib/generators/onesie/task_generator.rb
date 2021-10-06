# frozen_string_literal: true

module Onesie
  module Generators
    # Generates a new Onesie Task template
    class TaskGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('./templates', __dir__)

      def create_task
        template(
          'task.rb',
          "#{Onesie::TASKS_DIR}/#{file_name}.rb",
          class_name: class_name
        )
      end
    end
  end
end
