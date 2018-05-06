require 'rails_helper'
RSpec.describe UsersController, type: :controller do
  context 'get images feed' do
    it 'with valid seesion' do
      prepared_user
      stub_instagram_image_api
      get :show, params: { id: @prepared_user.id }, session: { user_id: @prepared_user.id }
      expect(response).to be_succes
      expect(assigns(:images)).to be_an_instance_of(WillPaginate::Collection)
      assigns(:images).each do |image|
        expect(image).to be_an_instance_of(Image)
      end
      expect(response).to render_template(:show)
      delete_prepared_user
    end
    it 'without valid seesion' do
      prepared_user
      @prepared_user.save
      get :show, params: { id: @prepared_user.id }, session: { user_id: '-1' }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(response.location)
      delete_prepared_user
    end
  end
end
