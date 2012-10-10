module CucumberTree
  class TempDir

    class << self

      def clear!
        root_path.children.each do |child|
          child.rmtree
        end
      end

      def child_path(dir_name)
        root_path.join(dir_name).to_path
      end

      private

      def root_path
        root_path = Rails.root.join('tmp','cucumber_tree')
        root_path.mkpath unless root_path.exist?
        root_path
      end

    end
  end
end
