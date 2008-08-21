ENV['SINATRA_ENV'] = 'test'

require 'main'
require 'sinatra/test/spec'
require 'mocha'
require 'factory_girl'
require File.join(File.dirname(__FILE__), 'factories')
