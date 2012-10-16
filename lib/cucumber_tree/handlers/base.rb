module CucumberTree
  module Handler
    class Base < Struct.new(:world)

      delegate :page, to: :world

    end
  end
end
