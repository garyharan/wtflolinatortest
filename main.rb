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

set_option(:env, ENV['SINATRA_ENV'].to_sym) if ENV['SINATRA_ENV']

# --------------------------------------------------
# Database Tables
# --------------------------------------------------
configure do
  DB = Sequel.sqlite

  DB.create_table! :meals do
    primary_key :id
    datetime :deadline
  end
  DB.create_table! :teams do
    primary_key :id
    varchar :name
  end
  DB.create_table! :people do
    primary_key :id
    varchar :first_name
    varchar :last_name
    varchar :email
  end
end

# --------------------------------------------------
# Models
# --------------------------------------------------
configure do
  class Meal < Sequel::Model; end
  class Team < Sequel::Model; end
  class Person < Sequel::Model; end
end

# --------------------------------------------------
# Fixtures
# --------------------------------------------------
configure :test, :development do
  Meal.create do |r|
    r.deadline = Time.now + (60 * 60 * 3)
  end
  Team.create do |r|
    r.name = 'StandoutJobs'
  end
end

# --------------------------------------------------
# Actions
# --------------------------------------------------
get '/' do
  #erb(:foo)
  'home'
end

get '/teams/:id' do
  Team[params[:id]].name
end

get 'meals/:id' do
end

use_in_file_templates!

__END__
@@ foo
blah

@@ index
aksdjfs
<%= alsf %>
