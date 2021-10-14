# frozen_string_literal: true

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
)

ActiveRecord::Schema.define do
  self.verbose = false

  create_table :onesie_logs, force: true do |t|
    t.string :task_name, null: false
    t.index :task_name, unique: true

    t.timestamps null: false
  end
end
