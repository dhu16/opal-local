# spec/controllers/films_controller_spec.rb
require 'rails_helper'

RSpec.describe FilmsController, type: :controller do
  fixtures :users, :films

  let(:user) { users(:user1) }
  let(:film) { films(:sample_film) } # Use the fixture data

  describe 'GET #new' do
    before do
      allow(controller).to receive(:current_user).and_return(user)
    end
    it 'renders the upload form template' do
      get :new
      expect(response).to render_template('upload-form')
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      before do
        allow(controller).to receive(:current_user).and_return(user)
      end

      it 'creates a new film' do
        valid_params = {
          title: 'Sample Film',
          description: 'A sample film',
          video: fixture_file_upload('sample.mp4', 'video/mp4'),
          thumbnail: fixture_file_upload('sample.png', 'image/png'),
          user: user
        }

        post :create, params: valid_params 

        expect(response).to redirect_to("/users/#{user.id}")
        expect(flash[:notice]).to include("Sample Film is live!")
      end
    end

    # ... (other contexts)

    context 'with invalid parameters' do
      before do
        allow(controller).to receive(:current_user).and_return(user)
      end

      it 'redirects to new film page with a flash alert' do
        invalid_params = {
          description: 'A sample film',
          video: fixture_file_upload('sample.mp4', 'video/mp4'),
          user: user
        }

        bad_video = {
          title: 'Title',
          description: 'A sample film',
          video: fixture_file_upload('sample.mp3', 'video/mp3'),
          thumbnail: fixture_file_upload('sample.png', 'image/png'),
          user: user
        }

        bad_image = {
          title: 'Title',
          description: 'A sample film',
          video: fixture_file_upload('sample.mp4', 'video/mp4'),
          thumbnail: fixture_file_upload('sample.svg', 'image/svg'),
          user: user
        }

        post :create, params: invalid_params
        expect(flash[:notice]).to include("Missing required fields")
        expect(response).to redirect_to('/upload_video')

        post :create, params: bad_video
        expect(flash[:notice]).to include("Invalid video filetype. Accepted types are mp4 and mpeg")
        expect(response).to redirect_to('/upload_video')

        post :create, params: bad_image
        expect(flash[:notice]).to include("Invalid thumbnail filetype. Accepted types are png and jpeg")
        expect(response).to redirect_to('/upload_video')
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'if owner of film' do
      before do
        allow(controller).to receive(:check_authentication)
        allow(controller).to receive(:current_user).and_return(user)
        allow(controller).to receive(:delete_from_s3)
        allow(Film).to receive(:find).and_return(film)
        film.video.attach(io: File.open(Rails.root.join('spec/fixtures/files/sample.mp4')), filename: 'sample.mp4', content_type: 'video/mp4')
        film.thumbnail.attach(io: File.open(Rails.root.join('spec/fixtures/files/sample.png')), filename: 'sample.png', content_type: 'image/png')
      end

      it 'deletes the film and shows flash notice' do
        expect(controller).to receive(:delete_from_s3).with(film.video)
        expect(controller).to receive(:delete_from_s3).with(film.thumbnail)
        expect(film).to receive(:destroy)
        delete :destroy, params: { id: film.id }
        expect(flash[:notice]).to include("Film deleted successfully.")
        expect(response).to redirect_to(user.profile_path)
      end

    end
  end

end
