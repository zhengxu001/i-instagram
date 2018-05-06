class User < ApplicationRecord
  def self.generate(code)
    @access_token = Instagram.get_access_token(code).access_token
    raw_user_info = Instagram.client(access_token: @access_token).user
    {
      access_token: @access_token,
      user_name: raw_user_info.username,
      user_id: raw_user_info.id,
      profile_picture: raw_user_info.profile_picture,
      full_name: raw_user_info.full_name
    }
  end

  def recent_media(_next_url)
    # Get images of next page if next_url
    # If there is no next_url provided, get the most recent 20 images
    images = []
    iamges_info = Instagram.client(access_token: access_token).user_recent_media
    iamges_info.each do |raw_image_info|
      images << Image.new(raw_image_info)
    end
    images
  end
end
