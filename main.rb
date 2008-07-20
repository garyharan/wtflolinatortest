#!/usr/bin/env ruby
# --------------------------------------------------
# Environment
# --------------------------------------------------
SINATRA_ROOT = File.expand_path(File.dirname(__FILE__)) unless defined? SINATRA_ROOT

Dir[File.join(SINATRA_ROOT, 'vendor/*')].each do |dir|
  $:.unshift "#{File.expand_path(dir)}/lib"
end

require 'rubygems'
require 'ruby-debug'
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
  class Person < Sequel::Model
    def full_name
      "#{first_name} #{last_name}"
    end
  end
end

# --------------------------------------------------
# Fixtures
# --------------------------------------------------
configure :test, :development do
  Meal.create do |r|
    r.deadline = Time.now + (60 * 60 * 3)
  end
  Team.create do |r|
    r.name = 'Standout Jobs'
  end
  Person.create do |r|
    r.first_name = 'Steve'
    r.last_name = 'Emploi'
    r.email = 'steve.e@lunchstatus.com'
  end
  Person.create do |r|
    r.first_name = 'Jack'
    r.last_name = 'Bauer'
    r.email = 'dabomb@gmail.com'
  end
end

# --------------------------------------------------
# Actions
# --------------------------------------------------
get '/' do
  File.read('views/test.html')
end

get '/teams/:id' do
  Team[params[:id]].name
end

get '/meals/:id' do
  Meal[params[:id]].deadline.to_s
end

get '/people/:id' do
  Person[params[:id]].full_name.to_s
end

use_in_file_templates!

__END__
@@ foo
blah
