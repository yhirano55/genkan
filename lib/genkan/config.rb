module Genkan
  class Config
    attr_accessor :user_class_name, :auto_acceptance, :cookie_expiration

    def initialize
      @user_class_name = "User"
      @auto_acceptance = false
      @cookie_expiration = 60 * 60 * 24 * 7 # 1.week
    end

    def user_class
      @user_class ||= user_class_name.safe_constantize
    end

    def current_user_method_name
      @current_user_method_name ||= "current_#{user_class_name.underscore.tr('/', '_')}".freeze
    end

    def auto_acceptance?
      !!auto_acceptance
    end
  end
end
