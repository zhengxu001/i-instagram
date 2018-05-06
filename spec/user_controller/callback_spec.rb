require 'rails_helper'
BASIC_CODE = '123456'.freeze
ERROR = 'test error'.freeze
INSTAGRAM_HOST = 'api.instagram.com'.freeze

RSpec.describe UsersController, type: :controller do

  context 'users connect to instagram' do

    it 'should be redirected to instagram with correct client information' do
      get :connect
      redirected_url = URI response.headers['Location']
      queries = Rack::Utils.parse_query redirected_url.query
      expect(response).to have_http_status(302)
      expect(redirected_url.host).to eq INSTAGRAM_HOST
      expect(queries['client_id']).to eq Rails.application.secrets.client_id
      expect(queries['redirect_uri']).to eq Rails.application.secrets.redirect_uri
    end
  end

  context 'callback from instagram' do

    context 'with correct code' do

      it 'update access token for exsiting users' do
        prepared_user
        stub_instagram_access_token_api
        stub_instagram_user_info_api
        original_user_count = User.count
        get :callback, params: { code: BASIC_CODE }
        expect(response).to have_http_status(302)
        expect(User.count).to eq original_user_count
        expect(session[:user_id]).to eq @prepared_user.id
        delete_prepared_user
      end

      it 'get access token and create new users' do
        stub_instagram_access_token_api
        stub_instagram_user_info_api
        original_user_count = User.count
        get :callback, params: { code: BASIC_CODE }
        expect(response).to have_http_status(302)
        expect(User.count).to eq original_user_count + 1
        expect(session[:user_id]).to be_truthy
      end
    end

    context 'user not authorized' do

      it 'user denied the access' do
        original_user_count = User.count
        get :callback, params: { error: ERROR }
        expect(response).to have_http_status(302)
        expect(User.count).to eq original_user_count
        expect(session[:user_id]).to eq nil
        expect(flash[:alert]).to match(/Something wrong with Instagram Authorization.*/)
      end
    end

    context 'user authorized but can not get access token' do

      it 'user revoke the access when getting access token' do
        original_user_count = User.count
        stub_instagram_access_token_api_with_error
        get :callback, params: { code: BASIC_CODE }
        expect(response).to have_http_status(302)
        expect(session[:user_id]).to eq nil
      end
    end
  end
end
