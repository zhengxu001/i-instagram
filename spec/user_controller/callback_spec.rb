require 'rails_helper'
RSpec.describe UsersController, :type => :controller do
  context 'redirect to instagram' do
    it 'user should be redirected to instagram with correct client id' do
      get :connect
      redirected_url = URI response.headers["Location"]
      queries = Rack::Utils.parse_query redirected_url.query
      p queries
      expect(response).to have_http_status(302)
      expect(redirected_url.host).to eq 'api.instagram.com'
      expect(queries["client_id"]).to eq Rails.application.secrets.client_id
    end
  end
  context 'callback from instagram' do
    context 'with correct code' do
      it 'update access token for exsiting users' do
        prepared_user
        prepared_user.save
        stub_instagram_access_token_api
        stub_instagram_user_info_api
        access_hash = JSON.parse file_fixture("access_token.json").read
        original_user_count = User.count
        get :callback, params: { code: '123456' }
        expect(response).to have_http_status(302)
        expect(User.count).to eq original_user_count
        delete_prepared_user
      end
      it 'get access token and create new users' do
        stub_instagram_access_token_api
        stub_instagram_user_info_api
        original_user_count = User.count
        get :callback, params: { code: '123456' }
        expect(response).to have_http_status(302)
        expect(User.count).to eq original_user_count + 1
      end
    end
    context 'user not authorized' do
      it 'user denied the access' do
        get :callback, params: { error: 'test' }
        expect(response).to have_http_status(200)
      end
    end
  end
end