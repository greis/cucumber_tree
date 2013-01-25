require "cucumber_tree/handlers/base"
require "cucumber_tree/handlers/databases/sqlite"
require "cucumber_tree/handlers/databases/postgresql"

module CucumberTree
  module Handler
    module Database

      def self.get_handler
        @get_handler ||= begin
          adapter = Rails.configuration.database_configuration[Rails.env]["adapter"]
          case adapter
          when /sqlite/
            Sqlite
          when /postgresql/
            Postgresql
          else
            raise "Database not supported: #{adapter}"
          end
        end
      end

    end
  end
end
