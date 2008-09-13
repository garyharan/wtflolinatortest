require 'tests/test_helper'
require File.join(File.dirname(__FILE__), '../main')

# --------------------------------------------------
# Models
# --------------------------------------------------
describe "Meal" do
  before(:each) do
    @meal = Factory.build(:meal)
  end

  it "should have a deadline" do
    Factory(:meal, :deadline => Time.now)
    Meal.first.deadline.should.not.be.nil
  end
end

describe "Person" do
  before(:each) do
    @person = Factory.build(:person)
  end
  
  it "should save" do
    test_person = Person.create do |r|
      r.first_name = 'Jack'
      r.last_name = 'Bauer'
      r.email = 'dabomb@gmail.com'
      r.user_name = 'dabomb'
    end
    test_person.should.not.be.nil
    test_person.first_name.should.equal 'Jack'
    test_person.user_name.should.equal 'dabomb'
  end

  it "should be able to display a full name" do
    @person.first_name = 'Frank'
    @person.last_name  = 'Sinatra'
    @person.full_name.should.equal 'Frank Sinatra'
    # -----
    @person.last_name  = ''
    @person.full_name.should.equal 'Frank'
    # -----
    @person.last_name  = nil
    @person.full_name.should.equal 'Frank'
    # -----
    @person.last_name  = 'Sinatra'
    @person.first_name = nil
    @person.full_name.should.equal 'Sinatra'
  end
end

# --------------------------------------------------
# Actions
# --------------------------------------------------
context "root" do
  specify "should show a default page with a name form" do
    get_it '/'
    should.be.ok
    body.should.include?("username")
    body.should.include?("organization")
  end
  
  specify "should allow user to type in a name and save it" do
    
  end
  
  specify "should show an existing name if one was previously saved (from cookies)" do
    
  end
end

context "/people/create" do
  specify "should create a person" do
    lambda {
        post_it "/people/create", {:username => "Jack", :organization => "Sheppard"}
    }.should change(Person.dataset, 'count').by(1)
  end
end

describe "/teams/:id" do

  it "should return the team's name" do
    t = Factory(:team, :name => 'cheezburger')
    get_it "/teams/#{t.id}"
    should.be.ok
    @response.body.include?(t.name).should.equal true
  end

end
