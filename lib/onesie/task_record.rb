# frozen_string_literal: true

require 'active_record'

module Onesie
  # Records when a specific Onesie Task was ran
  class TaskRecord < ActiveRecord::Base
    self.table_name = 'onesie_logs'

    def self.all_tasks
      order(:version).map(&:filename)
    end

    def filename
      "#{version}_#{name.underscore}"
    end
  end
end
