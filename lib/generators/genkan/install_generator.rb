require "rails/generators/migration"
require "generators/genkan/helper"

module Genkan
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      include Rails::Generators::Migration
      include Genkan::Generators::Helper

      source_root File.expand_path("../templates", __FILE__)

      class_option :model, optional: true,
                           type:     :string,
                           banner:   "model",
                           desc:     "Specify the model class name if you will use anything other than `User`",
                           default:  "User"

      def prepare_initializer
        template "initializer.erb", "config/initializers/genkan.rb"
      end

      def prepare_migration
        migration_template "migration.erb", "db/migrate/create_genkan_users.rb", migration_class_name: migration_class_name
      end

      def prepare_model
        template "model.erb", "app/models/#{model_file_path}.rb"
      end

      def prepare_controller
        inject_into_file "app/controllers/application_controller.rb", after: "class ApplicationController < ActionController::Base\n" do
          "  include Genkan::Authenticatable\n"
        end
      end

      def prepare_routes
        route "mount Genkan::Engine, at: '/'"
      end

      def prepare_view
        template "view.erb", "app/views/genkan/sessions/new.html.erb"
      end
    end
  end
end
