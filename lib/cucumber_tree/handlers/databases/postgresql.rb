require "cucumber_tree/handlers/base"

module CucumberTree
  module Handler
    module Database
      class Postgresql < Base
        def load(snapshot)
          dump_file = snapshot[:postgres_file]
          options = []
          options << "-U #{db_config['username']}" if db_config['username'].present?
          options << "-d #{db_config['database']}"
          options << "-f #{dump_file}"
          system("psql #{options.join(' ')}")
        end

        def save(snapshot)
          dump_file = ::CucumberTree::TempDir.file_name("postgres.dump")
          options = []
          options << "-f #{dump_file}"
          options << "-U #{db_config['username']}" if db_config['username'].present?
          options << "-a #{db_config['database']}"
          system("pg_dump #{options.join(' ')}")
          snapshot[:postgres_file] = dump_file
        end

        private

        def db_config
          Rails.configuration.database_configuration[Rails.env]
        end

      end
    end
  end
end
