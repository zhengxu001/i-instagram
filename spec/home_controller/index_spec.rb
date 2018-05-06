require 'rails_helper'
RSpec.describe HomeController, :type => :controller do
  context 'Access Home Page' do
    it 'with valid seesion' do
      prepared_user
      @prepared_user.save
      get :index, session: { user_id: @prepared_user.id}
      expect(response).to have_http_status(302)
      delete_prepared_user
    end
    it 'with valid seesion' do
      get :index
      expect(response).to have_http_status(200)
    end
  end
end