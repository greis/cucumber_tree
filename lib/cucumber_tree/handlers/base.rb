module CucumberTree
  module Handler
    class Base < Struct.new(:world, :scenario)

      def page
        world.page
      end

    end
  end
end
