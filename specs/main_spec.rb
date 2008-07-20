require 'specs/spec_helper'

describe Meal do

  it "should have deadline" do
    @meal = Meal.create(:deadline => Time.now)
    @meal.deadline.should_not be_nil
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