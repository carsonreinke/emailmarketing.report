OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  Rails.application.secrets[:google] = Rails.application.secrets[:google].with_indifferent_access()
  provider :google_oauth2, Rails.application.secrets[:google][:client_id], Rails.application.secrets[:google][:client_secret], {
    :hd => 'reinke.co',
    :path_prefix => '/admin/auth'
  }
end
