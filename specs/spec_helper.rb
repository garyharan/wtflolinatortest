ENV['SINATRA_ENV'] = 'test'

require 'main'
require 'sinatra/test/methods'
require 'factory_girl'
require 'rspec_hpricot_matchers'
require File.join(File.dirname(__FILE__), 'factories')

include Sinatra::Test::Methods

Spec::Runner.configure do |config|
  config.include(RspecHpricotMatchers)
end
