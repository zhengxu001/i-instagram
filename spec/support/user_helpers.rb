module UserHelpers
  def stub_instagram_access_token_api
    stub_request(:post, 'https://api.instagram.com/oauth/access_token/')
      .to_return(status: 200, body: file_fixture('access_token.json').read, headers: {})
  end

  def stub_instagram_user_info_api
    stub_request(:get, 'https://api.instagram.com/v1/users/self.json?access_token=fb2e77d.47a0479900504cb3ab4a1f626d174d2d')
      .to_return(status: 200, body: file_fixture('user_info.json').read, headers: {})
  end

  def stub_instagram_image_api
    stub_request(:get, 'https://api.instagram.com/v1/users/self/media/recent.json?access_token=fb2e77d.47a0479900504cb3ab4a1f626d174d2d')
      .to_return(status: 200, body: file_fixture('images.json').read, headers: {})
  end

  def prepared_user
    @prepared_user ||= User.new(prepared_data)
    @prepared_user.save
    @prepared_user
  end

  def delete_prepared_user
    @prepared_user.delete
  end

  def prepared_data
    @prepared_data ||= {
      access_token: 'fb2e77d.47a0479900504cb3ab4a1f626d174d2d',
      user_name: 'picasso',
      user_id: '1631492851',
      profile_picture: 'test_path',
      full_name: 'will'
    }
  end
end
