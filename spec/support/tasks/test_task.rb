# frozen_string_literal: true

module Onesie
  module Tasks
    class TestTask < Onesie::Task
      manual_task enabled: false

      def run; end
    end
  end
end
