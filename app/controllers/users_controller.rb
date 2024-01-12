class UsersController < ApplicationController
  before_action :check_authentication, only: [:show]
  helper ApplicationHelper
  def new
    render 'sign-up'
  end

  def create
    email = params.require :email
    password = params.require :password

    unless email.include?(".edu")
      flash[:alert] = 'Must use a valid school email.'
      redirect_to '/signup'
      return
    end

    if password.length < 6
      flash[:alert] = 'Password should be longer than 6 characters.'
      redirect_to '/signup'
      return
    end

    # TODO fix this !!
    unless User.with_email(email).nil?
      flash[:notice] = 'This email already has an account associated with it.'
      redirect_to '/signup'
      return
    end

    user = User.new(email: params[:email])
    user.password = params[:password]
    user.password_confirmation = params[:password]
    user.display_name = params[:display_name] 

    school = School.find_by(name: params[:school])
    user.school = school

    if user.save
      issue_token_to_cookies(user)
      redirect_to "/home"
    else
      flash[:notice] = 'Failed to create a new account.'
      render 'sign-up'
    end
  end

  def show
    check_authentication
    @user = current_user
    @films = @user.films.with_attached_video
    render 'user_profile'
  end

  def add_to_favorites
    @user = current_user
    film = Film.find_by(id: params[:film_id])
  
    if @user && film
      unless @user.favorite_films.include?(film)
        @user.favorite_films << film
        flash[:notice] = 'Film added to favorites.'
      else
        flash[:notice] = 'Film is already in favorites.'
      end
    else
      flash[:alert] = 'Failed to add film to favorites. Film not found.'
    end
  
    redirect_back fallback_location: root_path
  end
  

  def remove_from_favorites
    @user = current_user
    film = Film.find_by(id: params[:film_id])
  
    if @user && film
      if @user.favorite_films.include?(film)
        @user.favorite_films.delete(film)
        flash[:alert] = 'Film removed from favorites.'
      else
        flash[:alert] = 'Film is not in favorites.'
      end
    else
      flash[:alert] = 'Failed to remove film from favorites. Film not found.'
    end

    redirect_back fallback_location: root_path
  end
  

  def favorites
    @user = User.find(params[:id])
    @favorite_films = @user.favorite_films # Assuming there's an association set up for favorite_films
    render 'favorites'
  end
  
end

