# frozen_string_literal: true

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
)

ActiveRecord::Schema.define do
  self.verbose = false

  create_table :onesie_tasks, force: true do |t|
    t.string :name, null: false
    t.string :version, null: false

    t.index [:name, :version], unique: true # rubocop:disable Style/SymbolArray

    t.timestamps null: false
  end
end
