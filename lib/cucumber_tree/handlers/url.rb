require "cucumber_tree/handlers/base"

module CucumberTree
  module Handler
    class Url < Base

      def load(snapshot)
        url = snapshot[:url]
        page.visit url unless url.nil?
      end

      def save(snapshot)
        snapshot[:url] = page.current_path
      end

    end
  end
end
