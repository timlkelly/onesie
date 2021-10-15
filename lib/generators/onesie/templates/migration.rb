# frozen_string_literal: true

class CreateOnesieLogsTable < ActiveRecord::Migration<%= migration_version %>
  def change
    create_table :onesie_logs do |t|
      t.string :task_name, null: false
      t.index :task_name, unique: true

      t.timestamps null: false
    end

    execute("COMMENT ON COLUMN public.onesie_logs.task_name IS 'Identifier for the Onesie Task'")
    execute("COMMENT ON COLUMN public.onesie_logs.created_at IS 'Timestamp of record creation'")
    execute("COMMENT ON COLUMN public.onesie_logs.updated_at IS 'Timestamp of latest record update'")
  end
end
