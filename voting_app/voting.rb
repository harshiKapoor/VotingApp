require 'sinatra'
require 'yaml/store'
require 'erb'
# require 'sinatra/reloader'

get '/' do 
	@title = "Welcome to voting for interchange sprint!"
	erb :index
end

Choices = {
	'project1' => "Jmeter idea this is awesome project",
	'project2' => "this is excellent project" ,
	'project3' => 'this is rail project and is very innovative idea',

}

post '/cast' do
	@title = 'Thanks for casting your vote!'
	@vote = params['vote']
	# the file will be created if it does not exist
	@store = YAML::Store.new 'votes.yml'
	@store.transaction do 
		@store['votes'] ||= {}
		@store['votes'][@vote] ||= 0
		@store['votes'][@vote] += 1
	end
	erb :cast
end

get '/results' do
	@title = 'Results so far:'
	@store = YAML::Store.new 'votes.yml'
	# load data from store
	@votes = @store.transaction { @store['votes'] }
	erb :results
end