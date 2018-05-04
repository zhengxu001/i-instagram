require 'will_paginate/array'
class UsersController < ApplicationController
  before_action :authorize, only: [:show, :destroy]
  def show
    redirect_to @current_user if (@current_user.id != params[:id].to_i)
    # @user = User.find(params[:id])
    # @user = User.find_by_id(session[:current_user_id])
    @images = @current_user.recent_media(params[:next_url]) * 5
    @images = @images.paginate(page: params[:page], per_page: 6)
  end

  # def new
  #   redirect Instagram.authorize_url(:redirect_uri => callback_url)
  # end

  def authorize1
    redirect_to Instagram.authorize_url(scope: CGI::unescape('basic+public_content'))
  end

  # def create
  #   access_token = Instagram.get_access_token(params[:code], :redirect_uri => callback_url).access_token
  #   user_info = Client.new(access_token).user
  #   @user = User.new(user_info, access_token)
  #   session[:current_user_id] = @user.id
  #   redirect_to @user, notice: 'Session was successfully created.' if @user.save!
  # end

  def authorize2
    # access_token = Instagram.get_access_token(params[:code]).access_token
    # access_token = Instagram.get_access_token('eb41f5c0c6db4fc7a46e71d92b4fcd30').access_token
    # p access_token
    # user_info = Client.new(access_token).user
    # access_token = '1631492850.7b5b197.ef5d5670b150466783ab8176acfc200f'
    # user_info = InsClient.new("1631492850.7b5b197.ef5d5670b150466783ab8176acfc200f").user
    user_info = User.generate('1631492850.7b5b197.ef5d5670b150466783ab8176acfc200f')
    @user = User.new user_info
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user
    end
  end

  # ToDo: Logout
  def destroy
    redirect_to @current_user if (@current_user.id != params[:id].to_i)
    session[:user_id] = nil
    redirect_to @current_user , notice: 'Session was successfully destroyed.'
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end
