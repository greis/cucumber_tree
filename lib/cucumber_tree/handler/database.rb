require "cucumber_tree/handler/base"
require "yaml_db"

module CucumberTree
  module Handler
    class Database < Base

      def load(snapshot)
        SerializationHelper::Base.new(YamlDb::Helper).load_from_dir(snapshot[:dump_dir], false)
      end

      def save(snapshot)
        dump_dir = get_dump_dir
        SerializationHelper::Base.new(YamlDb::Helper).dump_to_dir(dump_dir)
        snapshot[:dump_dir] = dump_dir
      end

      def self.truncate!
        ActiveRecord::Base.connection.transaction do
          SerializationHelper::Dump.tables.each do |table|
            SerializationHelper::Load.truncate_table(table)
          end
        end
      end

      private

      def get_dump_dir
        root_path = Rails.root.join('tmp','cucumber_tree')
        root_path.mkpath unless root_path.exist?
        root_path.join(Time.now.to_f.to_s).to_path
      end
    end
  end
end
