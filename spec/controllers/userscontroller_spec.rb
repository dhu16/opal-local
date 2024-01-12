# spec/controllers/users_controller_spec.rb
require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  fixtures :users, :schools, :films

  describe 'POST create' do
    context 'with valid parameters' do
      it 'creates a new user and redirects to user profile page' do
        email = 'new_user@columbia.edu'
        new_user_attributes = { email: email, password: 'password123', school: 'Columbia University in the City of New York' }
        post :create, params: new_user_attributes
        uid = User.find_by(email: email).id
        expect(response).to redirect_to("/home")
      end
    end

    context 'with invalid email' do
      it 'redirects to new user page with a flash alert' do
        post :create, params: { email: 'invalid@example.com', password: 'password', school: 'Columbia University in the City of New York' }
        expect(response).to redirect_to('/signup')
        expect(flash[:alert]).to include('Must use a valid school email.')
      end
    end

    context 'with short password' do
      it 'redirects to new user page with a flash alert' do
        post :create, params: { email: "newuser@school.edu", password: 'short', school: 'Columbia University in the City of New York' }
        expect(response).to redirect_to('/signup')
        expect(flash[:alert]).to include('Password should be longer than 6 characters.')
      end
    end

    context 'with existing email' do
      it 'redirects to new user page with a flash notice' do
        post :create, params: { email: users(:user2).email, password: 'password', school: 'Columbia University in the City of New York' }
        expect(response).to redirect_to('/signup')
        expect(flash[:notice]).to include('This email already has an account associated with it.')
      end
    end
  end

  describe 'GET show' do
    let!(:user) { users(:user1) }
    let(:film) { films(:sample_film) }

    context 'when user is authenticated' do
      before do
        allow(controller).to receive(:check_authentication)
        allow(controller).to receive(:current_user).and_return(user)
      end

      it 'renders the user profile template' do
        get :show, params: { id: user.id }
        expect(response).to render_template('user_profile')
      end
    end

    context 'when user is not authenticated' do
      before do
        allow(controller).to receive(:check_authentication)
        expect(response).to render_template('login')
      end
    end
  end

  describe 'POST add_to_favorites' do
    let!(:user) { users(:user1) }
    let(:film) { films(:sample_film) }
  
    before do
      allow(controller).to receive(:current_user).and_return(user)
    end
  
    it 'adds film to favorites' do
      expect(user.favorite_films).not_to include(film)
  
      post :add_to_favorites, params: { id: user.id, film_id: film.id }
  
      expect(user.favorite_films).to include(film)
      expect(flash[:notice]).to eq('Film added to favorites.')
      expect(response).to redirect_to(root_path)
    end
    it 'handles failure to add film to favorites' do
      allow(controller).to receive(:current_user).and_return(user)
    
      post :add_to_favorites, params: { id: user.id, film_id: 'nonexistent_id' }
    
      expect(flash[:alert]).to eq('Failed to add film to favorites. Film not found.')
      expect(response).to redirect_to(root_path)    
    end
  end
  

  describe 'DELETE remove_from_favorites' do
    let!(:user) { users(:user1) }
    let(:film) { films(:sample_film) }
    let(:film2) { films(:sample_film2) }
  
    before do
      allow(controller).to receive(:current_user).and_return(user)
    end
  
    it 'removes film from favorites' do
      user.favorite_films << film
  
      expect(user.favorite_films).to include(film)
  
      delete :remove_from_favorites, params: { id: user.id, film_id: film.id }
  
      expect(user.favorite_films).not_to include(film)
      expect(flash[:alert]).to eq('Film removed from favorites.')
      expect(response).to redirect_to(root_path)
    end

  
    it 'handles attempt to remove non-existing film from favorites' do
      delete :remove_from_favorites, params: { id: user.id, film_id: 'nonexistent_id' }
  
      expect(flash[:alert]).to eq('Failed to remove film from favorites. Film not found.')
      expect(response).to redirect_to(root_path)
    end
  end  
end
