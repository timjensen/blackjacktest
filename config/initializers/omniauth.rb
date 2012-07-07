Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['254892331288540'], ENV['ce5d7eb006a7ff34d5dba4a3e0b4f533']
end

