class UsersController < ApplicationController
  def show
    @feed = get_feed(params[:next_url])
  end

  def new
    redirect Instagram.authorize_url(:redirect_uri => callback_url)
  end

  def create
    access_token = Instagram.get_access_token(params[:code], :redirect_uri => callback_url).access_token
    user_info = Client.new(access_token).user
    @user = User.new(user_info, access_token)
    redirect_to @user, notice: 'Session was successfully created.' if @user.save!
  end

  # ToDo: Revoke Authentication
  def destroy
    format.html { redirect_to sessions_url, notice: 'Session was successfully destroyed.' }
  end

  private

  def callback_url
    @callback_url ||= request.host + Instagram::CALLBACK_URL
  end

  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end
