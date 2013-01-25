module CucumberTree
  class TempDir

    class << self

      def clear!
        tmp_path.children.each do |child|
          child.rmtree
        end
      end

      def file_name(name)
        tmp_path.join(Time.now.to_f.to_s).tap(&:mkpath).join(name).to_path
      end

      private

      def tmp_path
        tmp_path = Rails.root.join('tmp','cucumber_tree')
        tmp_path.mkpath unless tmp_path.exist?
        tmp_path
      end

    end
  end
end
