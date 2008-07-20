#!/usr/bin/env ruby
require 'rubygems'
require 'sinatra'
require 'sequel'

DB = Sequel.sqlite

#DB.create_tabe :meals do
#  column 
#end

get '/' do
  'o hai'
end
