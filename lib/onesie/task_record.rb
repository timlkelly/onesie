# frozen_string_literal: true

require 'active_record'

module Onesie
  # Records when a specific Onesie Task was ran
  class TaskRecord < ActiveRecord::Base
    self.table_name = 'onesie_logs'
  end
end
