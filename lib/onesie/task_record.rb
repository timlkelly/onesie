# frozen_string_literal: true

require 'active_record'

module Onesie
  # Records when a specific Onesie Task was ran
  class TaskRecord < ActiveRecord::Base
    self.table_name = 'onesie_tasks'

    validates :version, uniqueness: {
      scope: :name,
      message: 'Version and Name has already been taken'
    }

    def self.all_tasks
      order(:version).map(&:filename)
    end

    def filename
      "#{version}_#{name.underscore}"
    end
  end
end
