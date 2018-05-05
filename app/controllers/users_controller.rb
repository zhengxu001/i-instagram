require 'will_paginate/array'
class UsersController < ApplicationController
  before_action :authorize, only: [:show, :destroy]
  def show
    redirect_to @current_user if (@current_user.id != params[:id].to_i)
    @current_user.access_token = "1631492850.7b5b197.e610dcdaef0844dd94d0e13c25c8afe5"
    @current_user.save
    @images = @current_user.recent_media(params[:next_url]) * 5
    @images = @images.paginate(page: params[:page], per_page: 6)
  end

  def new
    redirect Instagram.authorize_url(:redirect_uri)
  end

  def authorize1
    redirect_to Instagram.authorize_url(scope: CGI::unescape('basic+public_content'))
  end

  def callback
    params[:code] =  '7206ed1142664d64bc963701388f9d1f'
    if params[:error].present?
      flash[:alert] = "Something wrong with Instagram Authorization, Please try again!"
      render 'home/index'
      p 'here'
      return
    end
    access_token = Instagram.get_access_token(params[:code]).access_token
    p access_token
    user_info = User.generate(access_token)
    @user = User.find_by_user_id(user_info[:user_id])
    p 'here'
    if @user
      @user.update user_info
    else
      p 'here'
      @user = User.new user_info
    end
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user
    end
  end

  def authorize2
    user_info = User.generate('1631492850.7b5b197.e610dcdaef0844dd94d0e13c25c8afe5')
    @user = User.new user_info
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user
    end
  end

  def destroy
    redirect_to @current_user if (@current_user.id != params[:id].to_i)
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end
