Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, Rails.application.secrets.google_client_id, Rails.application.secrets.google_client_secret, :skip_jwt => true
    {scope: 'profile', access_type: 'online'}
end
