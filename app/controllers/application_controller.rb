class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  # def current_user
    # @current_user ||= User.first
  # end

  # helper_method :current_user
end
