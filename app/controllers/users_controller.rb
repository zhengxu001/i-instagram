require 'will_paginate/array'
class UsersController < ApplicationController
  before_action :authorize, only: %i[show destroy]
  def show
    redirect_to @current_user if @current_user.id != params[:id].to_i
    @images = begin
      @current_user.recent_media(params[:next_url]) * 4
    rescue StandardError
      []
    end
    @images = @images.paginate(page: params[:page], per_page: 6)
  end

  def connect
    redirect_to Instagram.authorize_url(scope: CGI.unescape('basic+public_content'))
  end

  def callback
    if params['error'].present?
      flash[:alert] = 'Something wrong with Instagram Authorization, Please try again!'
      redirect_to root_path
      return
    end
    user_info = begin
      User.generate(params['code'])
    rescue StandardError
      nil
    end
    if user_info.nil?
      redirect_to root_path
      flash[:alert] = 'Something wrong when getting Instagram access_token, Please try again!'
      return
    end
    @user = User.find_or_create_by(user_id: user_info[:user_id])
    @user.update user_info
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user
    end
  end

  def destroy
    redirect_to @current_user if @current_user.id != params[:id].to_i
    session[:user_id] = nil
    redirect_to root_path
  end
end
