class SessionsController < ApplicationController
  def new
    render 'login'
  end

  def create
    email = params.require :email
    password = params.require :password

    user = User.with_email(email)
    if user.nil? || !user.authenticate(password)
      flash[:notice] = 'Incorrect login information'
      redirect_to login_path
      return
    end

    issue_token_to_cookies(user)
    check_authentication
    
    redirect_to '/home'
  end

  #def show
    #check_authentication
    #if @user.nil?
      #flash[:alert] = 'User not found.'
      #redirect_to root_path
    #end

    #render 'user_profile'
  #end

  # Assuming you have a destroy method for logout
  def destroy
    cookies.delete(:auth)
    @user = nil
    redirect_to root_path
  end
end
