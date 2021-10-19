require 'flickr.rb'
Dotenv.load('.env')

class Flickr
	def self.flickr 
		Flickr.new(ENV['api_key'])
	end
end
