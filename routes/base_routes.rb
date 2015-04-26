require 'sinatra'
require 'json'
require 'sequel'

class BaseRoutes < Sinatra::Base
	set :public_folder, 'public'

	# loader.io validation endpoint
	get 'loaderio-3a56c6f3181bf46c14582978f30c3c83' do
		status 200
	end

	# loader.io validation endpoint
	get 'loaderio-211ffded21975d2a7404c4d83638692b' do
		status 200
	end

	get '/' do
		redirect '/index.html'	
	end

end

