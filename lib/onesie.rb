# frozen_string_literal: true

require 'colorize'

require_relative 'onesie/overseer'
require_relative 'onesie/railtie'
require_relative 'onesie/task'
require_relative 'onesie/task_record'
require_relative 'onesie/task_wrapper'
require_relative 'onesie/version'

module Onesie
  TASKS_DIR = 'onesie/tasks'

  # Initialize the Tasks namespace
  module Tasks
  end
end
