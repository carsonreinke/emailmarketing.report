class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user()
    session[:current_user]
  end

  def current_user=(user)
    session[:current_user] = user
  end
end
