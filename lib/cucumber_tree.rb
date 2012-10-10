env_caller = caller.detect{|f| f =~ /\/env\.rb:/} && !caller.detect{|f| f =~ /\/environment\.rb:/}
if env_caller
  require "cucumber_tree/version"
  require "cucumber_tree/hooks"
  require "cucumber_tree/configuration"
  require "cucumber_tree/handlers"
  require "cucumber_tree/temp_dir"

  module CucumberTree

    class << self

      attr_accessor :handlers

      def load_snapshot(world, scenario)
        truncate_data!
        parent_feature = scenario.feature.file.gsub(/\A(.*)\/.*(\.feature)\z/, '\1\2')
        snapshot = snapshots[parent_feature]
        set_handlers(world)
        if snapshot.present?
          handlers.each do |handler|
            handler.load(snapshot)
          end
        end
      end

      def save_snapshot(world, scenario)
        feature_file = scenario.feature.file
        snapshots[feature_file] = {}.tap do |snapshot|
          handlers.each do |handler|
            handler.save(snapshot)
          end
        end
      end

      def setup
        TempDir.clear!
      end

      private

      def set_handlers(world)
        # Handler::Url should always be the last
        self.handlers = [Handler::Database, Handler::Cookies, Handler::Variables, Handler::Url].map do |class_name|
          class_name.new(world)
        end
      end

      def snapshots
        @snapshots ||= {}
      end

      def truncate_data!
        Handler::Database.truncate!
      end

    end
  end
else
  warn "WARNING: cucumber_tree required outside of env.rb.  The rest of loading is being defered until env.rb is called.
  To avoid this warning, move 'gem cucumber_tree' under only group :test in your Gemfile"
end
