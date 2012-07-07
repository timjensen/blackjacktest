OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['305048129591548'], ENV['a4634faf4656e427efe70de9fb6fbb32']
end

