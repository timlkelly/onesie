# frozen_string_literal: true

module Onesie
  class Railtie < Rails::Railtie # :nodoc:
    rake_tasks do
      load('onesie/tasks/onesie.rake')
    end
  end
end
