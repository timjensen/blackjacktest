OmniAuth.config.logger = Rails.logger

# Rails.application.config.middleware.use OmniAuth::Builder do
# provider :facebook, "305048129591548", "caef290afbdf1088b6e2788e5fce6bd0", {client_options: {ssl: {ca_file: Rails.root.join('lib/assets/cacert.pem').to_s}}}
  
# end
#Koala patched for localhost 
# Koala.http_service.http_options = { :ssl => { :ca_file => Rails.root.join('lib/assets/cacert.pem').to_s } }

 Rails.application.config.middleware.use OmniAuth::Builder do
 provider :facebook, "133873710086332", "04f96d7f35efc7ffaa696f565ad48ddf"
 end