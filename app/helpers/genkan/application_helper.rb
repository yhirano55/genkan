module Genkan
  module ApplicationHelper
    private

      def method_missing(method_name, *args, &block)
        if Rails.application.routes.url_helpers.instance_methods.include?(method_name)
          main_app.send(method_name, *args)
        else
          super
        end
      end

      def respond_to_missing?(method_name, *args)
        Rails.application.routes.url_helpers.instance_methods.include?(method_name) || super
      end
  end
end
