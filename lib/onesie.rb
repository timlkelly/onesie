# frozen_string_literal: true

require 'colorize'

require_relative 'onesie/errors'
require_relative 'onesie/manager'
require_relative 'onesie/railtie'
require_relative 'onesie/runner'
require_relative 'onesie/task'
require_relative 'onesie/task_proxy'
require_relative 'onesie/task_record'
require_relative 'onesie/task_wrapper'
require_relative 'onesie/version'

module Onesie
  TASKS_DIR = 'onesie/tasks'

  # Initialize the Tasks namespace
  module Tasks
  end
end
