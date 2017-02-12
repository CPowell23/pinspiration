# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"] do
#     scope: 'profile', access_type: 'online'
#   end
<<<<<<< HEAD
# end
=======
# end
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, Rails.application.secrets.google_client_id, Rails.application.secrets.google_client_secret, :skip_jwt => true
    {scope: 'profile', access_type: 'online'}
end
>>>>>>> 685f56b98abddfdf9be7390a76ed28fb7e8ac52c
