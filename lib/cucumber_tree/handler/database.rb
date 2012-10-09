require "cucumber_tree/handler/base"
require "yaml_db"

module CucumberTree
  module Handler
    class Database < Base

      def load(snapshot)
        SerializationHelper::Base.new(YamlDb::Helper).load_from_dir(snapshot[:dump_dir])
      end

      def save(snapshot)
        dump_dir = "#{Rails.root}/tmp/cucumber_tree/#{Time.now.to_f}"
        SerializationHelper::Base.new(YamlDb::Helper).dump_to_dir(dump_dir)
        snapshot[:dump_dir] = dump_dir
      end
    end
  end
end
