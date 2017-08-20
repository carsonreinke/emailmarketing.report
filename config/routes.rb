require 'resque/server'
require 'resque-history/server'
require 'constraints/admin_constraint'

Rails.application.routes.draw do
  root 'root#index'

  namespace :api, :format => :json do
    get 'dkim/usage', :to => 'dkim#usage'
    get 'dkim/usage_overtime', :to => 'dkim#usage_overtime'

    get 'size/average_sizes', :to => 'size#average_sizes'
  end

  resources :emails, {:only => :show}
  delete '/logout' => redirect('/admin/logout'), :as => :logout

  namespace :admin do
    root 'sessions#index'
    get '/login' => redirect('/admin/auth/google_oauth2')
    get '/auth/:provider/callback', :to => 'sessions#create'
    delete '/logout', :to => 'sessions#destroy'
  end
  constraints(AdminConstraint) do
    mount RailsAdmin::Engine => '/admin/rails', :as => :rails_admin
    mount Resque::Server => '/admin/resque', :as => :admin_resque
  end
end
