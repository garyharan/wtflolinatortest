ENV['SINATRA_ENV'] = 'test'

require 'main'
require 'sinatra/test/spec'
require 'test/spec/extended'
require 'mocha'
require 'factory_girl'
require File.join(File.dirname(__FILE__), 'factories')

# Credits: http://project.ioni.st/post/218#post-218
module Test::Unit::AssertDifference
  def assert_difference(object, method = nil, difference = 1)
    initial_value = object.send(method)
    yield
    assert_equal initial_value + difference, object.send(method), "#{object}##{method}"
  end

  def assert_no_difference(object, method, &block)
    assert_difference object, method, 0, &block
  end
end