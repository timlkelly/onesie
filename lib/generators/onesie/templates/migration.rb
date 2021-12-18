# frozen_string_literal: true

class CreateOnesieTasksTable < ActiveRecord::Migration<%= migration_version %>
  def change
    create_table :onesie_tasks do |t|
      t.string :name, null: false
      t.string :version, null: false

      t.index [:name, :version], unique: true

      t.timestamps null: false
    end

    execute("COMMENT ON COLUMN public.onesie_tasks.name IS 'Name identifier for the Onesie Task'")
    execute("COMMENT ON COLUMN public.onesie_tasks.version IS 'Version identifier for the Onesie Task'")
    execute("COMMENT ON COLUMN public.onesie_tasks.created_at IS 'Timestamp of record creation'")
    execute("COMMENT ON COLUMN public.onesie_tasks.updated_at IS 'Timestamp of latest record update'")
  end
end
