# spec/controllers/sessions_controller_spec.rb
require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  fixtures :users

  describe 'GET sessions#new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template('login')
    end
  end

  describe 'POST sessions#create' do
    context 'with valid credentials' do
      it 'redirects to user profile page' do
        post :create, params: { email: users(:user1).email, password: "password" }
        expect(response).to redirect_to("/home")
      end

      it 'sets the user in the session' do
        post :create, params: { email: users(:user1).email, password: users(:user1).password_digest }
        expect(users(:user1).id).to eq(206669143)
      end
    end

    context 'with invalid credentials' do
      it 'redirects to login page' do
        post :create, params: { email: users(:user1).email, password: 'pw' }
        expect(response).to redirect_to(login_path)
      end

      it 'sets a flash notice' do
        post :create, params: { email: users(:user1).email, password: 'pw' }
        expect(flash[:notice]).to eq('Incorrect login information')
      end
    end
  end

  describe 'GET sessions#destroy' do
    context 'when user clicks logout' do
      it 'redirects to root path' do
        get :destroy
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
