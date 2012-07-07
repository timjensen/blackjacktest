OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '305048129591548', 'a4634faf4656e427efe70de9fb6fbb32'
end

