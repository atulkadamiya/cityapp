Rails.application.config.middleware.use OmniAuth::Builder do
	provider :twitter, '2xsSIVdVk9VRIoOHdymzQA', 'vuWuZLkjDLeMqMcUwdMK4dC9LpMs4zwWzvvV3XHX8I'
	provider :facebook, '498764290168979', 'c9969bc37bb7bcb295756b24d91e3d54', {:client_options => {:ssl => {:ca_path => "/etc/ssl/certs"}}}
end
