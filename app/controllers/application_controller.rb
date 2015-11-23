class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def login(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
  end

  def logout
    current_user.try(:reset_session_token)
    session[:session_token] = nil
  end

  def current_user
    return nil if session[:session_token].nil?

    User.find_by(session_token: session[:session_token])
  end

  private

  def redirect_signed_out_user
    redirect_to new_session_url if current_user.nil?
  end

  def redirect_signed_in_user
    redirect_to root_url if current_user
  end
end
