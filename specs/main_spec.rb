require 'specs/spec_helper'

# --------------------------------------------------
# Models
# --------------------------------------------------
describe Meal do

  before(:each) do
    @meal = Factory.build(:meal)
  end

  it "should have a deadline" do
    Factory(:meal, :deadline => Time.now)
    Meal.first.deadline.should_not be_nil
  end

end

describe Person do

  before(:each) do
    @person = Factory.build(:person)
  end

  it "should be able to display a full name" do
    @person.first_name = 'Frank'
    @person.last_name  = 'Sinatra'
    @person.full_name.should == 'Frank Sinatra'
    # -----
    @person.last_name  = ''
    @person.full_name.should == 'Frank'
    # -----
    @person.last_name  = nil
    @person.full_name.should == 'Frank'
    # -----
    @person.last_name  = 'Sinatra'
    @person.first_name = nil
    @person.full_name.should == 'Sinatra'
  end
end

# --------------------------------------------------
# Actions
# --------------------------------------------------
describe "/teams/:id" do

  it "should return the team's name" do
    t = Factory(:team, :name => 'cheezburger')
    get_it "/teams/#{t.id}"
    @response.body.include?(t.name).should be_true
    @response.should be_successful
  end

end
