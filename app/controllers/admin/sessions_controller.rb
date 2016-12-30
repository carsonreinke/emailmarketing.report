module Admin
  class SessionsController < ApplicationController
    def index()
      if self.current_user.nil?()
        redirect_to(admin_login_path())
      else
        redirect_to(rails_admin_path())
      end
    end

    def create()
      self.current_user = request.env['omniauth.auth'][:info][:email]
      redirect_to(admin_root_path())
    end

    def destroy()
    end
  end
end
