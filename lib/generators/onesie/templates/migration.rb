# frozen_string_literal: true

class CreateOnesieLogsTable < ActiveRecord::Migration<%= migration_version %>
  def change
    create_table :onesie_logs do |t|
      t.string :name, null: false
      t.string :version, null: false

      t.index [:name, :version], unique: true

      t.timestamps null: false
    end

    execute("COMMENT ON COLUMN public.onesie_logs.name IS 'Name identifier for the Onesie Task'")
    execute("COMMENT ON COLUMN public.onesie_logs.version IS 'Version identifier for the Onesie Task'")
    execute("COMMENT ON COLUMN public.onesie_logs.created_at IS 'Timestamp of record creation'")
    execute("COMMENT ON COLUMN public.onesie_logs.updated_at IS 'Timestamp of latest record update'")
  end
end
