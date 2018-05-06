require 'rails_helper'
RSpec.describe UsersController, :type => :controller do
  context 'Logout and Delete Session' do
    it 'with valid seesion' do
      prepared_user
      @prepared_user.save
      delete :destroy, params: { id: @prepared_user.id }, session: { user_id: @prepared_user.id}
      # expect(response).to have_http_status(302)
      # expect(User.count).to eq original_user_count
      delete_prepared_user
    end
  end
end