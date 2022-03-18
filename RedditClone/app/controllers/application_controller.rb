class ApplicationController < ActionController::Base
  helper_method :logged_in?, :current_user

  def login!(user)
    session[:session_token] = user.session_token
  end

  def logged_in?
    !!current_user
    
  end

  def log_out
    current_user.reset_session_token!
    session[:session_token] = nil
    @current_user = nil
  end

  def current_user
    return nil if session[:session_token].nil?
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def require_logged_in
    redirect_to new_session_url unless logged_in?
  end

  def require_logged_out
    redirect_to subs_url if logged_in?
  end
end
