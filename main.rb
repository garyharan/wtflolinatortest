#!/usr/bin/env ruby
# --------------------------------------------------
# Environment
# --------------------------------------------------
SINATRA_ROOT = File.expand_path(File.dirname(__FILE__)) unless defined? SINATRA_ROOT

Dir[File.join(SINATRA_ROOT, 'vendor/*')].each do |dir|
  $:.unshift "#{File.expand_path(dir)}/lib"
end

require 'rubygems'
require 'sinatra'
require 'sequel'

set_option :env, ENV['SINATRA_ENV'].to_sym if ENV['SINATRA_ENV']

DB = Sequel.sqlite

DB.create_table :meals do
  datetime :deadline
end
DB.create_table :team do
  text :name
end
DB.create_table :people do
  text :first_name
  text :last_name
  text :email
end

get '/' do
  'o hai'
end
