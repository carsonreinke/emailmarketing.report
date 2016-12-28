class SessionsController < ApplicationController
  def create()
    self.current_user = request.env['omniauth.auth'][:uid]
    redirect_to('/admin/rails')
  end
end
