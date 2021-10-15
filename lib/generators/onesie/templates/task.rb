# frozen_string_literal: true

module Onesie
  module Tasks
    class <%= class_name %> < Onesie::Task
      manual_task enabled: false

      def run
        # Write your Onesie Task here
      end
    end
  end
end
