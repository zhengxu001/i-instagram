class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  # prevents users that aren't logged in from accessing certain pages
  def authorize
    unless logged_in?
      redirect_to new_user_path
    end
  end
end
