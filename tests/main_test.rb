require 'tests/test_helper'
require File.join(File.dirname(__FILE__), '../main')
puts $"
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
  specify "should show a default page" do
    get_it '/'
    should.be.ok
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
