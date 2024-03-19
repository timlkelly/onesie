module Onesie
  # This class is used to verify that all onesie tasks have been run before
  # loading a web page if `config.onesie.task_error` is set to `:page_load`.
  # Influenced by ActiveRecord::Migration::CheckPending
  class CheckPending
    def initialize(app, file_watcher: ActiveSupport::FileUpdateChecker)
      @app = app
      @needs_check = true
      @mutex = Mutex.new
      @file_watcher = file_watcher
    end

    def call(env)
      @mutex.synchronize do
        @watcher ||= build_watcher do
          @needs_check = true
          Manager.check_pending!
          @needs_check = false
        end

        @needs_check ? @watcher.execute : @watcher.execute_if_updated
      end

      @app.call(env)
    end

    private

    def build_watcher(&block)
      paths = Array(Manager.tasks_path)
      @file_watcher.new([], paths, &block)
    end
  end
end
