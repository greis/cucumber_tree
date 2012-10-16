module CucumberTree
  module Handler
    class Base < Struct.new(:world)

      def page
        world.page
      end

    end
  end
end
