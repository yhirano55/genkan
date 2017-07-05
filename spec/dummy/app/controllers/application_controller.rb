class ApplicationController < ActionController::Base
  include Genkan::Authenticatable
  protect_from_forgery with: :exception
end
