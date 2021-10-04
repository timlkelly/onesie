# frozen_string_literal: true

class CreateOnesieTable < ActiveRecord::Migration<%= migration_version %>
  def change
    create_table :onesies do |t|
      t.string :filename, null: false
      t.index :filename, unique: true

      t.timestamps null: false
    end
  end
end
