require "cucumber_tree/handlers/base"

module CucumberTree
  module Handler
    class Url < Base

      def load(snapshot)
        puts "visiting #{snapshot[:url]}"
        page.visit snapshot[:url]
      end

      def save(snapshot)
        snapshot[:url] = page.current_path
      end

    end
  end
end
