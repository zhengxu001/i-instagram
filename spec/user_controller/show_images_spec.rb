  require 'rails_helper'

  RSpec.describe UsersController, :type => :controller do
    context 'GET Images Feed' do
      it 'with valid seesion' do
        prepared_user
        @prepared_user.save
        stub_instagram_image_api
        get :show, params: { id: @prepared_user.id }, session: { user_id: @prepared_user.id}
        delete_prepared_user
      end

      it 'without valid seesion' do
        prepared_user
        @prepared_user.save
        get :show, params: { id: @prepared_user.id }, session: { user_id: '-1'}
        expect(response).to have_http_status(302)
        # expect(response).to have_http_status(302)
        # expect(User.count).to eq original_user_count + 1
        delete_prepared_user
      end
    end
  end