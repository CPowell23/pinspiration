# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"] do
#     scope: 'profile', access_type: 'online'
#   end
# end
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"], :skip_jwt => true
    {scope: 'profile', access_type: 'online'}
end
