ENV['SINATRA_ENV'] = 'test'

require 'main'
require 'sinatra/test/methods'
require 'factory_girl'
require File.join(File.dirname(__FILE__), 'factories')

include Sinatra::Test::Methods
