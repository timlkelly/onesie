# frozen_string_literal: true

require 'rails/generators/active_record/migration'

module Onesie
  module Generators
    # Bootstrap the required migration file for Onesie
    class InstallGenerator < Rails::Generators::Base
      include ActiveRecord::Generators::Migration

      desc 'Bootstrap the Onesie gem'
      source_root File.expand_path('./templates', __dir__)

      MIGRATION_DEST = 'db/migrate/create_onesie_tasks_table.rb'
      TEMPLATE_FILENAME = 'migration.rb'

      def copy_migration
        migration_template(
          TEMPLATE_FILENAME,
          MIGRATION_DEST,
          migration_version: migration_version
        )
      end

      private

      def migration_version
        return unless rails5_or_above?

        "[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]"
      end

      def rails5_or_above?
        Rails::VERSION::MAJOR >= 5
      end
    end
  end
end
