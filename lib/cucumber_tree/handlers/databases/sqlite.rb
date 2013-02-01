require "cucumber_tree/handlers/base"

module CucumberTree
  module Handler
    module Database
      class Sqlite < Base
        def load(snapshot)
          FileUtils.cp(snapshot[:sqlite_file], db_file)
        end

        def save(snapshot)
          dump_file = ::CucumberTree::TempDir.file_name("dbfile.sqlite")
          FileUtils.cp(db_file, dump_file)
          snapshot[:sqlite_file] = dump_file
        end

        private

        def db_file
          Rails.root.join(Rails.configuration.database_configuration[Rails.env]["database"])
        end

      end
    end
  end
end
