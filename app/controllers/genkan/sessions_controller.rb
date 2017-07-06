require_dependency "genkan/application_controller"

module Genkan
  class SessionsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid do |_e|
      redirect_to genkan.login_path, alert: user.errors.full_messages.to_sentence
    end

    skip_before_action :authenticate, only: %i(new create failure)

    def new; end

    def create
      user.login!
      create_session
      redirect_to referer_or_root_path, notice: t('genkan.sessions.logged_in')
    end

    def failure
      redirect_to genkan.login_path, alert: t('genkan.sessions.failure')
    end

    def destroy
      destroy_session
      redirect_to genkan.login_path, notice: t('genkan.sessions.logged_out')
    end

    private

    def user
      @user ||= user_class.find_or_create_by(email: auth.dig(:info, :email))
    end

    def auth
      request.env['omniauth.auth']
    end

    def create_session
      session[:remember_token] = user.remember_token
    end

    def destroy_session
      session[:remember_token] = nil
    end

    def referer_or_root_path
      session.delete(:referer) || main_app.root_path
    end
  end
end
