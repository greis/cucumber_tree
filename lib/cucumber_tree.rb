env_caller = caller.detect{|f| f =~ /\/env\.rb:/} && !caller.detect{|f| f =~ /\/environment\.rb:/}
if env_caller
  require "cucumber_tree/version"
  require "cucumber_tree/hooks"
  require "cucumber_tree/configuration"
  require "cucumber_tree/handlers"
  require "cucumber_tree/temp_dir"

  module CucumberTree

    class << self

      attr_accessor :handler_instances
      attr_accessor :handler_classes

      def load_snapshot(world, scenario)
        clear_db!
        parent_feature = scenario.feature.file.gsub(/\A(.*)\/.*(\.feature)\z/, '\1\2')
        snapshot = snapshots[parent_feature]
        instantiate_handlers(world, scenario)
        if snapshot.present?
          handler_instances.each do |handler|
            handler.load(snapshot)
          end
        end
      end

      def save_snapshot(world, scenario)
        feature_file = scenario.feature.file
        if is_parent_feature?(feature_file)
          snapshots[feature_file] = {}.tap do |snapshot|
            handler_instances.each do |handler|
              handler.save(snapshot)
            end
          end
        end
      end

      def setup
        TempDir.clear!
      end

      def register_handler(*handlers)
        self.handler_classes ||= []
        self.handler_classes += handlers
      end

      private

      def is_parent_feature?(file)
        dir_name = file.gsub(/\A(.*)(\.feature)\z/, '\1')
        File.directory?(dir_name)
      end

      def instantiate_handlers(world, scenario)
        self.handler_instances = handler_classes.map do |class_name|
          class_name.new(world, scenario)
        end
      end

      def snapshots
        @snapshots ||= {}
      end

      def clear_db!
        Handler::Database.get_handler.clear_db!
      end
    end

    # Handler::Url should always be the last
    register_handler(Handler::Database.get_handler, Handler::Cookies, Handler::Variables, Handler::Url)

  end
else
  warn "WARNING: cucumber_tree required outside of env.rb.  The rest of loading is being defered until env.rb is called.
  To avoid this warning, move 'gem cucumber_tree' under only group :test in your Gemfile"
end
