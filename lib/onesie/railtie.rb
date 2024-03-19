# frozen_string_literal: true

require 'rails'

module Onesie
  class Railtie < Rails::Railtie # :nodoc:
    config.onesie = ActiveSupport::OrderedOptions.new

    initializer 'onesie.task_error' do |app|
      if config.onesie.task_error == :page_load
        config.app_middleware.insert_after ::ActiveRecord::Migration::CheckPending,
          Onesie::CheckPending,
          file_watcher: app.config.file_watcher
      end
    end

    rake_tasks do
      load('onesie/tasks/onesie.rake')
    end
  end
end
