require 'sinatra'
require 'haml'
require 'uri'

set :public_folder, 'public'

get '/' do haml :index ; end