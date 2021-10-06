# frozen_string_literal: true

class CreateOnesieLogsTable < ActiveRecord::Migration<%= migration_version %>
  def change
    create_table :onesie_logs do |t|
      t.string :task_name, null: false
      t.index :task_name, unique: true

      t.timestamps null: false
    end
  end
end
