require "cucumber_tree/handlers/base"

module CucumberTree
  module Handler
    class Variables < Base

      EXCLUDED_VARIABLES = %w(@__cucumber_step_mother @__natural_language @integration_session @app @controller @response @request)

      def load(snapshot)
        snapshot[:variables].each do |name, value|
          world.instance_variable_set(name, value)
        end
      end

      def save(snapshot)
        names = world.instance_variables.map { |var| var.to_s } - EXCLUDED_VARIABLES
        snapshot[:variables] = {}.tap do |hash|
          names.each do |name|
            hash[name] = world.instance_variable_get(name)
          end
        end
      end

    end
  end
end
