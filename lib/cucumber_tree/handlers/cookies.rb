require "cucumber_tree/handlers/base"

module CucumberTree
  module Handler
    class Cookies < Base

      def load(snapshot)
        snapshot[:cookies].each do |name, value|
          page.cookies[name] = value
        end
      end

      def save(snapshot)
        snapshot[:cookies] = {}.tap do |hash|
          page.cookies.each do |name, value|
            hash[name.to_sym] = value
          end
        end
      end

    end
  end
end
