class User < ApplicationRecord
  # attr_accessor :access_token, :user_name, :user_id, :profile_picture, :full_name

  def self.generate(access_token)
    @access_token =  access_token
    raw_user_info = ins_client.user
    user_info = {
      access_token: @access_token,
      user_name: raw_user_info.username,
      user_id: raw_user_info.user_id,
      profile_picture: raw_user_info.profile_picture,
      full_name: raw_user_info.full_name
    }
    # p user_info
    # new user_info
    # self.create user_info
    # p raw_user_info
    # @user_name = raw_user_info['username']
    # @user_id = raw_user_info['id']
    # @profile_picture = raw_user_info['profile_picture']
    # @full_name = raw_user_info['full_name']
  end

  # def initialize(raw_user_info)
  #   @access_token =  raw_user_info[:access_token]
  #   @user_name = raw_user_info[:user_name]
  #   @user_id = raw_user_info[:id]
  #   @profile_picture = raw_user_info[:profile_picture]
  #   @full_name = raw_user_info[:full_name]
  # end

  def recent_media(next_url)
    # Get images of next page if next_url
    # If there is no next_url provided, get the most recent 20 images
    # User.client.user_recent_media
    images = []
    iamges_info = Instagram.client(access_token: '1631492850.7b5b197.ef5d5670b150466783ab8176acfc200f').user_recent_media
    iamges_info.each do |raw_image_info|
      images << Image.build_image(raw_image_info)
    end
    return images
  end

  private
  def self.ins_client
    @client ||= Instagram.client(access_token: @access_token)
  end
end
