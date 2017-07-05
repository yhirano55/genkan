module Genkan
  module Helper
    extend ActiveSupport::Concern

    included do
      private
      delegate :user_class, :current_user_method_name, to: :class
    end

    class_methods do
      delegate :user_class, :current_user_method_name, to: :genkan_config

      def genkan_config
        Genkan.config
      end
    end
  end
end
