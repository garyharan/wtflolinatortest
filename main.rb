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
require 'thin'

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
    varchar :user_name
    varchar :email
    integer :team_id
  end
end

# --------------------------------------------------
# Models
# --------------------------------------------------
configure do
  class Meal < Sequel::Model; end
  class Team < Sequel::Model
    one_to_many :members, :class_name => 'Person'
  end
  class Person < Sequel::Model
    many_to_one :team
    validates_presence_of :user_name
    
    def full_name
      [first_name, last_name].join(' ').strip
    end
  end
end

# --------------------------------------------------
# Fixtures
# --------------------------------------------------
configure :development, :test do
  Meal.create do |r|
    r.deadline = Time.now + (60 * 60 * 3)
  end
  Team.create do |r|
    r.id   = 1
    r.name = 'Standout Jobs'
  end
  Person.create do |r|
    r.first_name = 'Steve'
    r.last_name = 'Emploi'
    r.email = 'steve.e@lunchstatus.com'
    r.user_name = 'steve.e'
  end
  Person.create do |r|
    r.first_name = 'Jack'
    r.last_name = 'Bauer'
    r.email = 'dabomb@gmail.com'
    r.user_name = 'dabomb'
    r.team_id = 1
  end
end

# --------------------------------------------------
# Actions
# --------------------------------------------------
get '/' do
  erb :home, :views_directory => File.dirname(__FILE__) + "/views"
end

get '/teams' do
  erb "<% for e in Team.dataset %><p><%= e.id %> <%= e.name %><% end %>"
end

get '/teams/:id' do
  @team_name = Team[params[:id]].name
  erb :teams_show, :views_directory => File.dirname(__FILE__) + "/views"
end

get '/meals/:id' do
  Meal[params[:id]].deadline.to_s
end

post '/account/create' do
  @username = params[:username]
  @organization = params[:organization]
  @team = Team.find_or_create(:name => @organization)
  @person = @team.members_dataset[:user_name => @username]
  if @person
    @notice = "#{@username} exists already on this team."
    redirect '/'
  else
    @notice = "Successfully created #{@username}"
    @person = Person.create(:user_name => @username)
    @team.add_member(@person)
    redirect "/people/#{@person.id}"
  end
end

get '/people/:id' do
  Person[params[:id]].user_name.to_s
end

use_in_file_templates!

__END__
@@ foo
blah
