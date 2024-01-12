# spec/controllers/home_controller_spec.rb
require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  fixtures :users
  let(:user) { users(:user1) }
  
  describe 'GET #index' do
    before do
      allow(controller).to receive(:current_user).and_return(user)
    end
    it 'renders the home template' do
      get :index
      expect(response).to render_template('index')
    end
  end
end
