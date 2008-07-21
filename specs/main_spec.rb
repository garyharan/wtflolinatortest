require 'specs/spec_helper'

# --------------------------------------------------
# Models
# --------------------------------------------------
describe Meal do

  it "should have a deadline" do
    Factory(:meal, :deadline => Time.now)
    Meal.first.deadline.should_not be_nil
  end

end

describe Person do

  before(:each) do
    @person = Person.create(:first_name => 'lolcat', :last_name => 'giraffeneck', :email => 'cheezburger@gmail.com')
  end

  it "should have attributes" do
    @person.keys.each{|attribute| attribute.should_not be_nil}
  end                   
  
  it "should be able to display a full name" do
    @person.full_name.should_not be_nil
  end
end