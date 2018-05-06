require 'rails_helper'
FAKE_USER_ID = -1
RSpec.describe UsersController, type: :controller do
  context 'Logout and Delete Session' do
    it 'with valid seesion' do
      prepared_user
      @prepared_user.save
      delete :destroy, params: { id: @prepared_user.id }, session: { user_id: @prepared_user.id }
      expect(response).to have_http_status(302)
      # User's Session has been cleared
      expect(session[:user_id]).to eq nil
      delete_prepared_user
    end

    it 'without valid seesion' do
      prepared_user
      @prepared_user.save
      delete :destroy, params: { id: @prepared_user.id }, session: { user_id: FAKE_USER_ID }
      expect(response).to have_http_status(302)
      # User's Session Does not Change
      expect(session[:user_id]).to eq FAKE_USER_ID
      delete_prepared_user
    end
  end
end
