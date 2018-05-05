  require 'rails_helper'

  describe '/api/users/callback' do

    context 'GET' do

      context 'with correct code' do
        # it 'update access token for exsiting users' do
        #   before do
        #     # use a Test Double instead of a real model
        #     @new_group = double(Group)
        #     @params = { :cdb_group => 'stub_cdb_group_param', :service_id => service }
        #     # using should_receive ensures the controller calls new correctly
        #     Group.should_receive(:new).with(@params[:cdb_group]).and_return(@new_group)
        #   end
        #   stub_instagram_access_token_api
        #   stub_instagram_user_info_api
        #   prepare_user
        #   access_hash = JSON.parse file_fixture("access_token.json").read
        #   original_user_count = User.count
        #   get '/users/authorize?code=123456'
        #   expect(response).to have_http_status(302)
        #   updated_user = User.find_by_user_id access_hash["id"]
        #   expect(updated_user.access_token).to eq updated_user["access_token"]
        #   expect(User.count).to eq original_user_count
        # end

        it 'get access token and create new users' do
          stub_instagram_access_token_api
          stub_instagram_user_info_api
          original_user_count = User.count
          get '/callback?code=123456'
          expect(response).to have_http_status(302)
          expect(User.count).to eq original_user_count + 1
        end

        def stub_instagram_access_token_api
          stub_request(:post, "https://api.instagram.com/oauth/access_token/").
          with(
           body: {"client_id"=>"7b5b197214584d648db946e68b79c094", "client_secret"=>"8b5772632f5b44d9b925be38e1bffb88", "code"=>"123456", "grant_type"=>"authorization_code", "redirect_uri"=>"http://213.233.150.101:4567/oauth/callback"},
           headers: {
            'Accept'=>'application/json; charset=utf-8',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Content-Type'=>'application/x-www-form-urlencoded',
            'User-Agent'=>'Instagram Ruby Gem 1.1.6'
            }).
          to_return(status: 200, body: file_fixture("access_token.json").read, headers: {})
        end

        def stub_instagram_user_info_api
          stub_request(:get, "https://api.instagram.com/v1/users/self.json?access_token=fb2e77d.47a0479900504cb3ab4a1f626d174d2d").
          with(
           headers: {
            'Accept'=>'application/json; charset=utf-8',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization'=>'Token token="fb2e77d.47a0479900504cb3ab4a1f626d174d2d"',
            'User-Agent'=>'Instagram Ruby Gem 1.1.6'
            }).
          to_return(status: 200, body: file_fixture("user_info.json").read, headers: {})
        end

        def prepare_user
          User.new(prepared_data).save
        end

        def prepared_data
          @prepared_data ||= {
            access_token: 'fb2e77d.47a0479900504cb3ab4a1f626d174d2d',
            user_name: 'picasso',
            user_id: 'picasso.will',
            profile_picture: 'test_path',
            full_name: 'will'
          }
        end
      end

      # context 'user not authorized' do
      #   it 'user denied the access' do
      #     stub_request(:get, "https://api.instagram.com/v1/users/self.json?access_token=fb2e77d.47a0479900504cb3ab4a1f626d174d2d").
      #     with(
      #      headers: {
      #       'Accept'=>'application/json; charset=utf-8',
      #       'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      #       'Authorization'=>'Token token="fb2e77d.47a0479900504cb3ab4a1f626d174d2d"',
      #       'User-Agent'=>'Instagram Ruby Gem 1.1.6'
      #       }).
      #     to_return(status: 200, body: file_fixture("access_token.json").read, headers: {})

      #     get '/users/authorize?code=123456'
      #     expect(response).to have_http_status(:unauthorized)
      #   end
      # end
    end
  end