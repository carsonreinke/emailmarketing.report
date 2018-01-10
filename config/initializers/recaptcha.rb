Recaptcha.configure do |config|
  Rails.application.secrets[:recaptcha] = Rails.application.secrets[:recaptcha].with_indifferent_access()
  config.site_key  = Rails.application.secrets[:recaptcha][:site_key]
  config.secret_key = Rails.application.secrets[:recaptcha][:secret_key]
end
