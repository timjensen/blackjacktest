OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "305048129591548", "caef290afbdf1088b6e2788e5fce6bd0"
  
end

