class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= begin
      User.find(session[:user_id])
    rescue StandardError
      nil
    end if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  # prevents users that aren't logged in from accessing certain pages
  def authorize
    redirect_to root_path unless logged_in?
  end
end
