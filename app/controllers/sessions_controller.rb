class SessionsController < ApplicationController
  def create()
    self.current_user = request.env['omniauth.auth']
  end
end
