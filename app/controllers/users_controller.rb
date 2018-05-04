require 'will_paginate/array'
class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @images = @user.recent_media(params[:next_url]).paginate(page: params[:page], per_page:6)
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
  #   redirect_to @user, notice: 'Session was successfully created.' if @user.save!
  # end

  def authorize2
    # access_token = Instagram.get_access_token(params[:code]).access_token
    # access_token = Instagram.get_access_token('eb41f5c0c6db4fc7a46e71d92b4fcd30').access_token
    # p access_token
    # user_info = Client.new(access_token).user
    access_token = '1631492850.7b5b197.ef5d5670b150466783ab8176acfc200f'
    # user_info = InsClient.new("1631492850.7b5b197.ef5d5670b150466783ab8176acfc200f").user
    @user = User.generate('1631492850.7b5b197.ef5d5670b150466783ab8176acfc200f')
    # p user_info
    # @user = User.new(user_info, access_token)
    redirect_to @user, notice: 'Session was successfully created.' if @user.save
  end

  # ToDo: Revoke Authentication
  def destroy
    format.html { redirect_to sessions_url, notice: 'Session was successfully destroyed.' }
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end
