require 'resque/server'
require 'constraints/admin_constraint'

Rails.application.routes.draw do
  root 'root#index'

  get '/auth/:provider/callback', to: 'sessions#create'
  get '/admin' => redirect('/auth/google_oauth2')
  constraint(AdminConstraint) do
    mount RailsAdmin::Engine => '/admin/rails', as: 'rails_admin'
    mount Resque::Server.new, :at => '/admin/resque'
  end
end
