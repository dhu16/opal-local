Rails.application.routes.draw do
  root 'sessions#new'

  get 'login', to: 'sessions#new', as: :login
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy', as: :logout

  get 'signup', to: 'users#new', as: :signup
  post 'signup', to: 'users#create'

  get 'home', to: 'home#index', as: :home
  get 'upload_video', to: 'films#new'
  post 'upload_video', to: 'films#create'
  get 'films/upload_video', to: redirect('upload_video')
  post 'films/upload_video', to: redirect('upload_video')
  get 'play_video/:id', to: 'films#show', as: :play_video
  delete 'delete_video/:id', to: 'films#destroy', as: :delete

  get 'users/:id', to: 'users#show', as: 'user'

  get '/users/:id/favorites', to: 'users#favorites', as: :user_favorites

  get 'search', to: "films#search", as: :search
  # RESTful routes for users
  # The 'show' route is defined to provide a path helper 'user_path' for individual users
  resources :users, only: [:show, :create]

  resources :users do
    member do
      
    end
    resources :films, only: [:new, :create, :show, :destroy]
    post 'add_to_favorites', on: :member
    delete 'remove_from_favorites', on: :member
  end

  resources :films do
    resources :comments, only: [:create, :index]
  end

  

  # If films are not tied to users directly, uncomment the following:
  # resources :films, only: [:new, :create, :show]

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  
end
