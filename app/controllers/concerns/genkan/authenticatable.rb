module Genkan
  module Authenticatable
    include Genkan::Helper
    extend ActiveSupport::Concern

    included do
      before_action :authenticate
      helper_method current_user_method_name, :logged_in?
    end

    private

      def authenticate
        unless logged_in?
          store_location
          redirect_to genkan.login_path, notice: t("genkan.sessions.required")
        end
      end

      define_method(current_user_method_name) do
        instance_variable_get(:"@#{current_user_method_name}") || \
          instance_variable_set(:"@#{current_user_method_name}", user_class.active.find_by(remember_token: session[:remember_token]))
      end

      def logged_in?
        send(current_user_method_name).present?
      end

      def store_location
        session[:referer] = request.fullpath
      end
  end
end
