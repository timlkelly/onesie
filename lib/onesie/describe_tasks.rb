# frozen_string_literal: true

require 'forwardable'

module Onesie
  # List pending Tasks to be run
  class DescribeTasks
    extend Forwardable

    def self.run
      new.run
    end

    def_delegator :manager, :pending_tasks
    def_delegator :manager, :pending_tasks?

    def initialize
      @manager = Manager.new
    end

    def run
      unless pending_tasks?
        puts 'No pending tasks'
        return
      end

      puts 'Available Tasks to run:'
      pending_tasks.each do |task_proxy|
        announce(task_proxy)
      end
    end

    private

    attr_reader :manager

    def announce(task_proxy)
      puts "* #{task_proxy.name}".cyan
      puts "bundle exec rake onesie:run['#{task_proxy.filename}']\n"
    end
  end
end
