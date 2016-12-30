require 'resque/server'
require 'constraints/admin_constraint'

Rails.application.routes.draw do
  root 'root#index'

  namespace :admin do
    root 'sessions#index'
    get '/login' => redirect('/admin/auth/google_oauth2')
    get '/auth/:provider/callback', :to => 'sessions#create'
    get '/logout', :to => 'sessions#destroy'
  end
  constraints(AdminConstraint) do
    mount RailsAdmin::Engine => '/admin/rails', :as => :rails_admin
    mount Resque::Server => '/admin/resque', :as => :admin_resque
  end
end
