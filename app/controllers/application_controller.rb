require 'jwt'

class ApplicationController < ActionController::Base
  helper_method :current_user
  helper ApplicationHelper

  def jwt_secret
    #Rails.application.credentials.json_secret
    "012345678901234567890123456789"
  end

  def check_authentication
    @user = current_user
    return if @user

    #render 'public/401', status: :unauthorized
    redirect_to login_path
  end

  # returns user, or nil if not signed in
  def current_user
    auth_cookie = cookies[:auth]

    return if !auth_cookie

    jwt = JWT.decode(auth_cookie, jwt_secret, true, algorithm: 'HS256')
    user_id = jwt[0]['user_id']
    User.find(user_id)
  end

  def issue_token_to_cookies(user)
    # places a token in cookies that auths the current user
    cookies[:auth] = {
      value: cookie(user),
      httponly: true,
      secure: Rails.env.production?
    }
  end

  private

  def cookie(user)
    payload = {
      user_id: user.id,
      exp: Time.now.to_i + 30 * 24 * 3600 # 30 days from now
    }
    JWT.encode(payload, jwt_secret, 'HS256')
  end
end
