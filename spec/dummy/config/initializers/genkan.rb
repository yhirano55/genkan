Genkan.configure do |config|
  config.user_class_name = 'User'
  config.auto_acceptance = false
end

Genkan::Engine.configure do |config|
  config.middleware.use OmniAuth::Builder do
    provider(
      :google_oauth2,
      ENV.fetch('GOOGLE_OAUTH_CLIENT_ID') { 'google_oauth_client_id' },
      ENV.fetch('GOOGLE_OAUTH_CLIENT_SECRET') { 'google_oauth_client_secret' },
      name: 'google',
      scope: 'email'
    )
  end
end
