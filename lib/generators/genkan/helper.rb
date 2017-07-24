module Genkan
  module Generators
    module Helper
      extend ActiveSupport::Concern

      private

        def model_class_name
          options.has_key?(:model) ? options[:model].classify : "User"
        end

        def model_file_path
          model_name.underscore
        end

        def model_path
          @model_path ||= File.join("app", "models", "#{model_file_path}.rb")
        end

        def namespace
          Rails::Generators.namespace if Rails::Generators.respond_to?(:namespace)
        end

        def namespaced?
          !!namespace
        end

        def table_name_prefix
          model_class_name.to_s.split("::")[0..-2].join("_").underscore.presence
        end

        def model_name
          if namespaced?
            [namespace.to_s] + [model_class_name]
          else
            [model_class_name]
          end.join("::")
        end

        def migration_class_name
          if Rails::VERSION::MAJOR >= 5
            "ActiveRecord::Migration[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]"
          else
            "ActiveRecord::Migration"
          end
        end

        class_methods do
          # Define the next_migration_number method (necessary for the migration_template method to work)
          def next_migration_number(dirname)
            if ActiveRecord::Base.timestamped_migrations
              sleep 1 # make sure each time we get a different timestamp
              Time.new.utc.strftime("%Y%m%d%H%M%S")
            else
              "%.3d" % (current_migration_number(dirname) + 1)
            end
          end
        end
    end
  end
end
