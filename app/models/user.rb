class User < ApplicationRecord
  attr_accessor :access_token, :user_name, :user_id, :profile_picture, :full_name

  def initlialize(user_info, access_token)
  	@access_token =  access_token
  	@user_name = user_info['user_name']
  	@user_id = user_info['id']
  	@profile_picture = user_info['profile_picture']
  	@full_name = user_info['full_name']
  end

  def recent_media(next_url)
  	# Get images of next page if next_url
  	# If there is no next_url provided, get the most recent 20 images
  	client.user_recent_media
  end

  private

  def client
    @client ||= Instagram.client(:access_token => @access_token)
  end
end
