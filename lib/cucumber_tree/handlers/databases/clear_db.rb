module CucumberTree
  module Handler
    module Database
      module ClearDB

        def clear_db_with(type)
          @type = type
        end

        def clear_db!
          ActiveRecord::Base.connection.transaction do
            ActiveRecord::Base.connection.tables.each do |table|
              command = case @type
                        when :delete
                          "DELETE FROM #{ActiveRecord::Base.connection.quote_table_name(table)}"
                        when :truncate
                          "TRUNCATE TABLE #{ActiveRecord::Base.connection.quote_table_name(table)} CASCADE"
                        end
              ActiveRecord::Base.connection.execute(command)
            end
          end
        end
      end
    end
  end
end

