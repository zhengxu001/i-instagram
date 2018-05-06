class HomeController < ApplicationController
  def index
    if logged_in?
      redirect_to @current_user 
    else
      render :layout => false
    end
  end
end